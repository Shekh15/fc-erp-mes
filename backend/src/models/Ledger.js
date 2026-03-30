const Ledger = require("./Ledger");
const pool = require("../config/database");

// ================= ADD ENTRY =================
exports.addEntry = async (conn, {
  client_id,
  entry_type,
  reference_type,
  reference_id,
  debit = 0,
  credit = 0,
  entry_date = new Date(),
  created_by
}) => {

  // Safety conversions
  const debitAmount = Number(debit) || 0;
  const creditAmount = Number(credit) || 0;
  const clientId = Number(client_id);

  if (!entry_type) {
    throw new Error("entry_type is required for ledger entry");
  }

  // Insert ledger row
  await conn.query(`
    INSERT INTO Fc_client_ledger
    (client_id, entry_type, reference_type, reference_id, debit, credit, entry_date, created_by)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  `, [
    clientId,
    entry_type,
    reference_type,
    reference_id,
    debitAmount,
    creditAmount,
    entry_date,
    created_by
  ]);

  // Update cached client balance
  await conn.query(`
    UPDATE Fc_clients
    SET balance = balance + ? - ?
    WHERE id = ?
  `, [debitAmount, creditAmount, clientId]);
};



// ================= GET CLIENT LEDGER =================
exports.getClientLedger = async (clientId) => {

  const [rows] = await pool.query(`
    SELECT *
    FROM Fc_client_ledger
    WHERE client_id = ?
    ORDER BY id ASC
  `, [clientId]);

  return rows;
};

// ================= GET CLIENT BALANCE =================
exports.getClientBalance = async (clientId) => {

  const [rows] = await pool.query(`
    SELECT balance
    FROM Fc_clients
    WHERE id = ?
  `, [clientId]);

  if (!rows.length) return 0;

  return Number(rows[0].balance);
};


// ================= GET CLIENT BALANCE FROM LEDGER=================
exports.getClientBalanceFromLedger = async (clientId) => {

  const [rows] = await pool.query(`
    SELECT IFNULL(SUM(debit),0) - IFNULL(SUM(credit),0) as balance
    FROM Fc_client_ledger
    WHERE client_id = ?
  `, [clientId]);

  return Number(rows[0].balance);
};