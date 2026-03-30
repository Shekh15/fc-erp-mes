const pool = require("../config/database");

// ================= GET ALL =================
exports.getAll = async () => {
  const [rows] = await pool.query(
    `SELECT * FROM Fc_stocks ORDER BY stockId ASC`
  );
  return rows;
};

// ================= CREATE =================
exports.create = async (data) => {
  const {
    stockRecordeddate,
    productId,
    productName,
    producedPackets,
    salesPacket,
    currentStock
  } = data;

  const [result] = await pool.query(
    `INSERT INTO Fc_stocks
     (stockRecordeddate, productId, productName, producedPackets, salesPacket, currentStock)
     VALUES (?, ?, ?, ?, ?, ?)`,
    [
      stockRecordeddate,
      productId,
      productName,
      producedPackets,
      salesPacket,
      currentStock
    ]
  );

  // Fetch inserted row
  const [rows] = await pool.query(
    `SELECT * FROM Fc_stocks WHERE stockId = ?`,
    [result.insertId]
  );

  return rows[0];
};

// ================= UPDATE =================
exports.update = async (stockId, fields) => {
  const keys = Object.keys(fields);
  const values = Object.values(fields);

  const setQuery = keys.map((key) => `${key} = ?`).join(", ");

  await pool.query(
    `UPDATE Fc_stocks SET ${setQuery} WHERE stockId = ?`,
    [...values, stockId]
  );

  // Fetch updated row
  const [rows] = await pool.query(
    `SELECT * FROM Fc_stocks WHERE stockId = ?`,
    [stockId]
  );

  return rows[0];
};



// const pool = require("../config/database");

// exports.getAll = async () => {
//   const result = await pool.query(`SELECT * FROM "Fc_stocks" ORDER BY stockId ASC`);
//   return result.rows;
// };

// exports.create = async (data) => {
//   const { stockRecordeddate, productId, productName, producedPackets, salesPacket, currentStock } = data;
//   const result = await pool.query(
//     `INSERT INTO "Fc_stocks"(stockRecordeddate, productId, productName, producedPackets, salesPacket, currentStock)
//      VALUES($1, $2, $3, $4, $5, $6) RETURNING *`,
//     [stockRecordeddate, productId, productName, producedPackets, salesPacket, currentStock]
//   );
//   return result.rows[0];
// };

// exports.update = async (stockId, fields) => {
//   const keys = Object.keys(fields);
//   const values = Object.values(fields);
//   const setQuery = keys.map((key, idx) => `"${key}" = $${idx + 1}`).join(", ");

//   const result = await pool.query(
//     `UPDATE "Fc_stocks" SET ${setQuery} WHERE "stockid" = $${keys.length + 1} RETURNING *`,
//     [...values, stockId]
//   );

//   return result.rows[0];
// };
