const Bill = require("./Bill");
const Ledger = require("./Ledger");
const pool = require("../config/database");

// ================= GET ALL =================
exports.getAll = async () => {
    const [rows] = await pool.query(
        `SELECT * FROM Fc_payments ORDER BY id ASC`
    );
    return rows;
};

// ================= CREATE PAYMENT =================
exports.create = async (data, userId) => {

    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {

        const {
            clientId,
            invoiceId,
            paymentDate,
            amount,
            paymentMode
        } = data;

        // 1️⃣ Insert Payment
        const [result] = await conn.query(`
      INSERT INTO Fc_payments
      (client_id, invoice_id, payment_date, amount, payment_mode, created_by)
      VALUES (?, ?, ?, ?, ?, ?)
    `, [
            clientId,
            invoiceId || null,
            paymentDate,
            amount,
            paymentMode,
            userId
        ]);

        const paymentId = result.insertId;

        // 2️⃣ Ledger Credit Entry
        if (invoiceId) {

            // Payment applied to bill
            await Ledger.addEntry(conn, {
                client_id: clientId,
                reference_type: "PAYMENT",
                reference_id: invoiceId,   // ✅ BILL ID
                debit: 0,
                credit: amount,
                created_by: userId
            });

            await Bill.updatePaymentStatus(conn, invoiceId);

        } else {

            // Advance payment (not linked to bill)
            await Ledger.addEntry(conn, {
                client_id: clientId,
                reference_type: "ADVANCE",
                reference_id: paymentId,
                debit: 0,
                credit: amount,
                created_by: userId
            });
        }

        // 🔥 Add this
        if (invoiceId) {
            await Bill.updatePaymentStatus(conn, invoiceId);
        }

        await conn.commit();
        conn.release();

        const [rows] = await pool.query(
            `SELECT * FROM Fc_payments WHERE id = ?`,
            [paymentId]
        );

        return rows[0];

    } catch (err) {
        await conn.rollback();
        conn.release();
        throw err;
    }
};