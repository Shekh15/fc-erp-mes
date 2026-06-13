const Production = require("../models/Production");

// ================= GET ALL =================
exports.getAll = async (req, res) => {
  try {
    const data = await Production.getAll();

    res.status(200).json({
      success: true,
      data,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// ================= CREATE =================
exports.create = async (req, res) => {
  try {
    const result = await Production.create(req.body);

    res.status(201).json({
      success: true,
      message: "Production entry created successfully",
      data: result,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// ================= UPDATE =================
exports.update = async (req, res) => {
  try {
    const result = await Production.update(req.params.id, req.body);

    res.status(200).json(result);
  } catch (error) {
    console.error(error);

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};


