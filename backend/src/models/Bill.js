const Ledger = require("./Ledger");
const pool = require("../config/database");

// ================= GET ALL =================
exports.getAll = async () => {
  const [rows] = await pool.query(
    `SELECT * FROM Fc_bills 
     WHERE is_active = 1
     ORDER BY id ASC`
  );
  return rows;
};

// ================= CREATE =================
exports.create = async (data, userId) => {

  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {

    const { clientId, clientName, inhouse, items, total, paidAmount, previousAmount } = data;

    console.log("Bill Created:::", data);

    const [result] = await conn.query(`
      INSERT INTO Fc_bills
      (clientId, clientName, inhouse, items, total, paidAmount, previousAmount, payment_status, created_by)
      VALUES (?, ?, ?, ?, ?, ?, ?, 'UNPAID', ?)
    `, [
      clientId,
      clientName,
      inhouse,
      JSON.stringify(items),
      total,
      paidAmount,
      previousAmount,
      userId
    ]);

    const billId = result.insertId;

    // Set original_bill_id = self
    await conn.query(`
      UPDATE Fc_bills 
      SET original_bill_id = ?
      WHERE id = ?
    `, [billId, billId]);

    // Ledger Debit Entry
    await Ledger.addEntry(conn, {
      client_id: clientId,
      entry_type: "BILL",
      reference_type: "BILL",
      reference_id: billId,
      debit: total,
      credit: 0,
      entry_date: new Date(),
      created_by: userId
    });

      await Ledger.addEntry(conn, {
        client_id: clientId,
        entry_type: "PAYMENT",
        reference_type: "PAYMENT",
        reference_id: billId,
        debit: 0,
        credit: paidAmount,
        entry_date: new Date(),
        created_by: userId
      });

    await exports.updatePaymentStatus(conn, billId);

    await conn.commit();
    conn.release();

    const [rows] = await pool.query(
      `SELECT * FROM Fc_bills WHERE id = ?`,
      [billId]
    );

    return rows[0];

  } catch (err) {
    await conn.rollback();
    conn.release();
    throw err;
  }
};

// ================= UPDATE (VERSIONING) =================
exports.update = async (originalBillId, data, userId) => {

  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {

    console.log("On update body payload:::", data);

    const { clientName, inhouse, items, total, paidAmount, previousAmount } = data;

    console.log("Original Bill Id:::", originalBillId);
    // Get active version
    const [rows] = await conn.query(`
      SELECT * FROM Fc_bills
      WHERE original_bill_id = ?
      AND is_active = 1
    `, [originalBillId]);

    if (!rows.length) {
      throw new Error("Active bill not found");
    }

    const oldBill = rows[0];

    // Deactivate old version
    await conn.query(`
      UPDATE Fc_bills
      SET is_active = 0
      WHERE id = ?
    `, [oldBill.id]);

    // Reverse old ledger
    await Ledger.addEntry(conn, {
      client_id: oldBill.clientId,
      entry_type: "BILL_REVERSAL",
      reference_type: "BILL",
      reference_id: oldBill.id,
      debit: 0,
      credit: oldBill.total,
      entry_date: new Date(),
      created_by: userId
    });

    // Reverse previous payments
    // const [payments] = await conn.query(`
    // SELECT * FROM Fc_client_ledger
    // WHERE reference_type = 'PAYMENT'
    // AND reference_id = ?
    // AND entry_type = 'PAYMENT'`, [oldBill.id]);

    const [payments] = await conn.query(`
      SELECT *
      FROM Fc_client_ledger
      WHERE reference_type = 'PAYMENT'
      AND reference_id = ?
      AND entry_type = 'PAYMENT'
      AND id NOT IN (
        SELECT reference_id
        FROM Fc_client_ledger
        WHERE entry_type = 'PAYMENT_REVERSAL'
      )`, [oldBill.id]);



    for (const payment of payments) {

      await Ledger.addEntry(conn, {
        client_id: oldBill.clientId,
        entry_type: "PAYMENT_REVERSAL",
        reference_type: "PAYMENT",
        reference_id: payment.reference_id,
        debit: payment.credit,
        credit: 0,
        entry_date: new Date(),
        created_by: userId
      });

    }

    // Insert new version
    const [newResult] = await conn.query(`
      INSERT INTO Fc_bills
      (clientId, clientName, inhouse, items, total, paidAmount, previousAmount,
       payment_status, created_by,
       original_bill_id, version_number)
      VALUES (?, ?, ?, ?, ?, ?, ?, 'UNPAID', ?, ?, ?)
    `, [
      oldBill.clientId,
      clientName,
      inhouse,
      JSON.stringify(items),
      total,
      paidAmount,
      previousAmount,
      userId,
      originalBillId,
      oldBill.version_number + 1
    ]);

    const newBillId = newResult.insertId;

    // New Ledger Debit
    await Ledger.addEntry(conn, {
      client_id: oldBill.clientId,
      entry_type: "BILL",
      reference_type: "BILL",
      reference_id: newBillId,
      debit: data.total,
      credit: 0,
      entry_date: new Date(),
      created_by: userId
    });

    // 🟢 STEP 9 — If Paid Amount Exists During Update
    if (paidAmount && paidAmount > 0) {

      await Ledger.addEntry(conn, {
        client_id: oldBill.clientId,
        entry_type: "PAYMENT",
        reference_type: "PAYMENT",
        reference_id: newBillId,
        debit: 0,
        credit: paidAmount,
        entry_date: new Date(),
        created_by: userId
      });
    }

    await exports.updatePaymentStatus(conn, newBillId);

    await conn.commit();
    conn.release();

    const [newRows] = await pool.query(
      `SELECT * FROM Fc_bills WHERE id = ?`,
      [newBillId]
    );

    return newRows[0];

  } catch (err) {
    await conn.rollback();
    conn.release();
    throw err;
  }
};

// ================= UPDATE PAYMENT STATUS =================
exports.updatePaymentStatus = async (conn, billId) => {

  const [billInfo] = await conn.query(
    `SELECT original_bill_id, total FROM Fc_bills WHERE id = ?`,
    [billId]
  );

  if (!billInfo.length) return;

  const originalBillId = billInfo[0].original_bill_id;
  const billTotal = Number(billInfo[0].total);

  const [ledgerRows] = await conn.query(`
    SELECT IFNULL(SUM(credit),0) as totalPaid
    FROM Fc_client_ledger
    WHERE entry_type = 'PAYMENT'
    AND reference_id IN (
        SELECT id FROM Fc_bills
        WHERE original_bill_id = ?
    )
    AND credit > 0
  `, [originalBillId]);

  const totalPaid = Number(ledgerRows[0].totalPaid);

  let status = "UNPAID";

  if (totalPaid >= billTotal && billTotal > 0) {
    status = "PAID";
  } else if (totalPaid > 0) {
    status = "PARTIAL";
  }

  await conn.query(`
    UPDATE Fc_bills
    SET payment_status = ?
    WHERE id = ?
  `, [status, billId]);
};

//Written for future if required
exports.reversePayment = async (ledgerId, userId) => {

  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {

    const [rows] = await conn.query(`
      SELECT * FROM Fc_client_ledger
      WHERE id = ? AND entry_type = 'PAYMENT'
    `, [ledgerId]);

    if (!rows.length) {
      throw new Error("Payment not found");
    }

    const payment = rows[0];

    await Ledger.addEntry(conn, {
      client_id: payment.client_id,
      entry_type: "PAYMENT_REVERSAL",
      reference_type: "PAYMENT",
      reference_id: payment.reference_id,
      debit: payment.credit,
      credit: 0,
      entry_date: new Date(),
      created_by: userId
    });

    await conn.commit();
    conn.release();

  } catch (err) {
    await conn.rollback();
    conn.release();
    throw err;
  }

};