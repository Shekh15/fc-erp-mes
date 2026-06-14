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
  const [rows] = await pool.query(`SELECT * FROM Fc_products ORDER BY id ASC`);
  console.log("Products:::", rows);
  return rows;
};

exports.getAvailableProducts = async () => {
  const [rows] = await pool.query(`
    SELECT *
    FROM Fc_products
    WHERE current_stock > 0
    ORDER BY id ASC
  `);

  return rows;
};

// ================= CREATE =================
exports.create = async ({ name, price }) => {
  const [result] = await pool.query(
    `INSERT INTO Fc_products (name, price) VALUES (?, ?)`,
    [name, price],
  );

  // MySQL doesn't support RETURNING *
  const [rows] = await pool.query(`SELECT * FROM Fc_products WHERE id = ?`, [
    result.insertId,
  ]);

  return rows[0];
};

// exports.update = async (id, fields) => {
//   const keys = Object.keys(fields);
//   const values = Object.values(fields);

//   if (keys.length === 0) {
//     throw new Error("No fields provided for update");
//   }

//   const setQuery = keys.map((key) => `${key} = ?`).join(", ");

//   await pool.query(`UPDATE Fc_products SET ${setQuery} WHERE id = ?`, [
//     ...values,
//     id,
//   ]);

//   const [rows] = await pool.query(`SELECT * FROM Fc_products WHERE id = ?`, [
//     id,
//   ]);

//   return rows[0];
// };

// ================= STOCK LIST =================
exports.getStockList = async () => {
  const [rows] = await pool.query(`
    SELECT
      id,
      name,
      current_stock,
      category,
      is_active
    FROM Fc_products
    ORDER BY name
  `);

  return rows;
};

// ================= ADJUST STOCK =================
exports.adjustStock = async (data) => {
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction();

    // Verify product exists

    console.log("Data for adjust::::", data)

    const [productRows] = await conn.query(
      `
      SELECT *
      FROM Fc_products
      WHERE id = ?
      FOR UPDATE
      `,
      [data.productId],
    );

    if (!productRows.length) {
      throw new Error("Product not found");
    }

    const product = productRows[0];

    // Save adjustment history

    await conn.query(
      `
      INSERT INTO Fc_stock_adjustments
      (
        product_id,
        old_stock,
        new_stock,
        reason,
        created_by
      )
      VALUES
      (?, ?, ?, ?, ?)
      `,
      [
        data.productId,
        product.current_stock,
        data.newStock,
        data.reason,
        data.created_by || null,
      ],
    );

    // Update product stock

    await conn.query(
      `
      UPDATE Fc_products
      SET current_stock = ?
      WHERE id = ?
      `,
      [data.newStock, data.productId],
    );

    await conn.commit();

    return {
      success: true,
      message: "Stock adjusted successfully",
    };
  } catch (error) {
    await conn.rollback();

    throw error;
  } finally {
    conn.release();
  }
};
