const pool = require("../config/database");

exports.getAll = async () => {
  const [rows] = await pool.query(`
    SELECT *
    FROM Fc_units
    WHERE is_active = 1
    ORDER BY unit_name
  `);

  return rows;
};

exports.getById = async (id) => {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM Fc_units
    WHERE id = ?
  `,
    [id],
  );

  return rows[0];
};

exports.create = async (data) => {
  const [result] = await pool.query(
    `
    INSERT INTO Fc_units
    (
      unit_code,
      unit_name
    )
    VALUES
    (?, ?)
  `,
    [data.unit_code, data.unit_name],
  );

  return result.insertId;
};

exports.update = async (id, data) => {
  await pool.query(
    `
    UPDATE Fc_units
    SET
      unit_code = ?,
      unit_name = ?
    WHERE id = ?
  `,
    [data.unit_code, data.unit_name, id],
  );
};

exports.deactivate = async (id) => {
  await pool.query(
    `
    UPDATE Fc_units
    SET is_active = 0
    WHERE id = ?
  `,
    [id],
  );
};
