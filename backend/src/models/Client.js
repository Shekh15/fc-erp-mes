// const pool = require("../config/database");

// exports.getAll = async () => {
//   const result = await pool.query(`SELECT * FROM "Fc_clients" ORDER BY id ASC`);
//   return result.rows;
// };

// exports.create = async ({ name, price }) => {
//   const result = await pool.query(
//     `INSERT INTO "Fc_clients"(name, price) VALUES($1, $2) RETURNING *`,
//     [name, price]
//   );
//   return result.rows[0];
// };

const pool = require("../config/database");

// ================= GET ALL =================
exports.getAll = async () => {
  const [rows] = await pool.query(
    `SELECT * FROM Fc_clients ORDER BY id ASC`
  );
  return rows;
};

// ================= CREATE =================
exports.create = async ({ name, price }) => {
  const [result] = await pool.query(
    `INSERT INTO Fc_clients (name, price) VALUES (?, ?)`,
    [name, price]
  );

  // Fetch inserted row manually (MySQL has no RETURNING *)
  const [rows] = await pool.query(
    `SELECT * FROM Fc_clients WHERE id = ?`,
    [result.insertId]
  );

  return rows[0];
};

