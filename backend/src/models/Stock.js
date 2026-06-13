const pool = require("../config/database");

exports.decreaseStock = async (conn, productId, qty) => {

  const [rows] = await conn.query(
    `
    SELECT current_stock
    FROM Fc_products
    WHERE id = ? FOR UPDATE
    `,
    [productId]
  );

  if (!rows.length) {
    throw new Error(`Product ${productId} not found`);
  }

  const stock = Number(rows[0].current_stock);

  if (stock < Number(qty)) {
    throw new Error(`Insufficient stock for product ${productId}`);
  }

  await conn.query(
    `
    UPDATE Fc_products
    SET current_stock = current_stock - ?
    WHERE id = ?
    `,
    [qty, productId]
  );
};

exports.increaseStock = async (conn, productId, qty) => {

  await conn.query(
    `
    UPDATE Fc_products
    SET current_stock = current_stock + ?
    WHERE id = ?
    `,
    [qty, productId]
  );
};