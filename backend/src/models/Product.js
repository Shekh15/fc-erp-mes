// const pool = require("../config/database");

// exports.getAll = async () => {
//   const result = await pool.query(`SELECT * FROM "Fc_products" ORDER BY id ASC`);
//   return result.rows;
// };

// exports.create = async ({ name, price }) => {
//   const result = await pool.query(
//     `INSERT INTO "Fc_products"(name, price) VALUES($1, $2) RETURNING *`,
//     [name, price]
//   );
//   return result.rows[0];
// };

const pool = require("../config/database");

// ================= GET ALL =================
exports.getAll = async () => {
  const [rows] = await pool.query(
    `SELECT * FROM Fc_products ORDER BY id ASC`
  );
  console.log("Products:::",rows);
  return rows;
};

// ================= CREATE =================
exports.create = async ({ name, price }) => {
  const [result] = await pool.query(
    `INSERT INTO Fc_products (name, price) VALUES (?, ?)`,
    [name, price]
  );

  // MySQL doesn't support RETURNING *
  const [rows] = await pool.query(
    `SELECT * FROM Fc_products WHERE id = ?`,
    [result.insertId]
  );

  return rows[0];
};

exports.update = async (id, fields) => {
  const keys = Object.keys(fields);
  const values = Object.values(fields);

  if (keys.length === 0) {
    throw new Error("No fields provided for update");
  }

  const setQuery = keys.map((key) => `${key} = ?`).join(", ");

  await pool.query(
    `UPDATE Fc_products SET ${setQuery} WHERE id = ?`,
    [...values, id]
  );

  const [rows] = await pool.query(
    `SELECT * FROM Fc_products WHERE id = ?`,
    [id]
  );

  return rows[0];
};

