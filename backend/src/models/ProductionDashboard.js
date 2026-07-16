const pool = require("../config/database");

// ================= DASHBOARD =================

exports.getDashboard = async (fromDate, toDate) => {
  // -----------------------------
  // Product Master
  // -----------------------------

  const [products] = await pool.query(
    `
        SELECT

            id,

            name,

            batch_size,

            packets_per_batch,

            rate_per_kg,

            price

        FROM Fc_products

        WHERE is_active = 1

        ORDER BY id
        `,
  );

  // -----------------------------
  // Production Entries
  // -----------------------------

  const [productions] = await pool.query(
    `
        SELECT

            pe.id,

            DATE_FORMAT
            (
                pe.production_date,
                '%Y-%m-%d'
            ) AS production_date,

            pe.product_id,

            pe.quantity,

            pe.produced_packets,

            pe.remarks,

            p.name AS product_name

        FROM Fc_production_entries pe

        INNER JOIN Fc_products p

            ON p.id = pe.product_id

        WHERE pe.production_date
              BETWEEN ? AND ?

        ORDER BY
            pe.production_date,
            p.id
        `,
    [fromDate, toDate],
  );

  return {
    products,

    productions,
  };
};
