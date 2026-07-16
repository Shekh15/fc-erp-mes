const pool = require("../config/database");
const Stock = require("./Stock");

// ================= GET ALL =================
exports.getAll = async () => {
  const [rows] = await pool.query(
    `
    SELECT
      pe.id,

      DATE_FORMAT(
        pe.production_date,
        '%Y-%m-%d'
      ) AS production_date,

      pe.product_id,
      pe.quantity,
      pe.produced_packets,
      pe.remarks,

      pe.createdAt,
      pe.created_by,
      pe.updatedAt,
      pe.updated_by,

      p.name AS product_name

    FROM Fc_production_entries pe

    INNER JOIN Fc_products p
      ON p.id = pe.product_id

    ORDER BY pe.production_date DESC,
             pe.id DESC
    `,
  );

  return rows;
};

// ================= CREATE =================
exports.create = async (productionData) => {
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction();

    const [result] = await conn.query(
      `
      INSERT INTO Fc_production_entries
      (
        production_date,
        product_id,
        quantity,
        produced_packets,
        remarks,
        created_by,
        updated_by
      )
      VALUES
      (
        ?, ?, ?, ?, ?, ?, ?
      )
      `,
      [
        productionData.production_date,
        productionData.product_id,
        productionData.quantity,
        productionData.produced_packets,
        productionData.remarks || null,
        productionData.created_by,
        productionData.created_by,
      ],
    );

    await Stock.increaseStock(
      conn,
      productionData.product_id,
      productionData.produced_packets,
    );

    await conn.commit();

    return {
      success: true,
      id: result.insertId,
    };
  } catch (error) {
    await conn.rollback();
    throw error;
  } finally {
    conn.release();
  }
};

// ================= CREATE BULK =================
exports.createBulk = async (data, userId) => {
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction();

    for (const item of data.items) {

      // Skip empty rows
      if (
        !item.produced_packets ||
        Number(item.produced_packets) <= 0
      ) {
        continue;
      }

      // -------------------------
      // Save production entry
      // -------------------------
      await conn.query(
        `
        INSERT INTO Fc_production_entries
        (
          production_date,
          product_id,
          quantity,
          produced_packets,
          remarks,
          created_by,
          updated_by
        )
        VALUES
        (?, ?, ?, ?, ?, ?, ?)
        `,
        [
          data.production_date,
          item.product_id,
          item.quantity,
          item.produced_packets,
          data.remarks || null,
          userId,
          userId,
        ]
      );

      // -------------------------
      // Increase finished stock
      // -------------------------
      await Stock.increaseStock(
        conn,
        item.product_id,
        item.produced_packets
      );
    }

    await conn.commit();

    return {
      success: true,
      message: "Production saved successfully"
    };

  } catch (err) {

    await conn.rollback();
    throw err;

  } finally {

    conn.release();

  }
};

// ================= UPDATE =================
exports.update = async (id, productionData) => {
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction();

    // Load old production

    const [rows] = await conn.query(
      `
      SELECT *
      FROM Fc_production_entries
      WHERE id = ? FOR UPDATE
      `,
      [id],
    );

    if (!rows.length) {
      throw new Error("Production entry not found");
    }

    const oldProduction = rows[0];

    // Reverse old stock effect

    await Stock.decreaseStock(
      conn,
      oldProduction.product_id,
      oldProduction.produced_packets,
    );

    // Update production

    await conn.query(
      `
      UPDATE Fc_production_entries
      SET
        production_date = ?,
        product_id = ?,
        quantity = ?,
        produced_packets = ?,
        remarks = ?,
        updated_by = ?
      WHERE id = ?
      `,
      [
        productionData.production_date,
        productionData.product_id,
        productionData.quantity,
        productionData.produced_packets,
        productionData.remarks || null,
        productionData.updated_by,
        id,
      ],
    );

    // Apply new stock effect

    await Stock.increaseStock(
      conn,
      productionData.product_id,
      productionData.produced_packets,
    );

    await conn.commit();

    return {
      success: true,
      message: "Production updated successfully",
    };
  } catch (error) {
    await conn.rollback();
    throw error;
  } finally {
    conn.release();
  }
};
