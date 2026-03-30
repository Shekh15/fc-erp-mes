const pool = require("../config/database");

// ================= GET ALL ACTIVE =================
exports.getAllActive = async () => {
  const [rows] = await pool.query(
    `SELECT id, name, description
     FROM Fc_price_lists
     WHERE is_active = 1
     ORDER BY priority DESC`
  );
  return rows;
};

// ================= GET CLIENT DEFAULT PRICE LIST =================
exports.getByClient = async (clientId) => {
  const [rows] = await pool.query(
    `SELECT pl.id, pl.name, pl.description
     FROM Fc_clients c
     JOIN Fc_price_lists pl ON c.price_list_id = pl.id
     WHERE c.id = ?
       AND pl.is_active = 1`,
    [clientId]
  );

  return rows;
};

// ================= GET PRICE LIST ITEMS =================
exports.getItems = async (priceListId) => {
  const [rows] = await pool.query(
    `SELECT 
        pli.product_id,
        p.name AS productName,
        pli.price
     FROM Fc_price_list_items pli
     JOIN Fc_products p ON pli.product_id = p.id
     WHERE pli.price_list_id = ?
       AND pli.is_active = 1`,
    [priceListId]
  );

  return rows;
};