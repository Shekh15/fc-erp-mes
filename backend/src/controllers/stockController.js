const Stock = require("../models/Stock");

exports.getStocks = async (req, res, next) => {
  try {
    const stocks = await Stock.getAll();
    res.json(stocks);
  } catch (err) {
    next(err);
  }
};

exports.createStock = async (req, res, next) => {
  try {
    const stock = await Stock.create(req.body);
    res.status(201).json(stock);
  } catch (err) {
    next(err);
  }
};

exports.updateStock = async (req, res, next) => {
  try {
    const stock = await Stock.update(req.params.id, req.body);
    res.json(stock);
  } catch (err) {
    next(err);
  }
};
