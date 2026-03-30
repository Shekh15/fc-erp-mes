const PriceList = require("../models/PriceList");

exports.getAllActive = async (req, res, next) => {
  try {
    const lists = await PriceList.getAllActive();
    res.json(lists);
  } catch (err) {
    next(err);
  }
};

exports.getByClient = async (req, res, next) => {
  try {
    const lists = await PriceList.getByClient(req.params.clientId);
    res.json(lists);
  } catch (err) {
    next(err);
  }
};

exports.getItems = async (req, res, next) => {
  try {
    const items = await PriceList.getItems(req.params.priceListId);
    res.json(items);
  } catch (err) {
    next(err);
  }
};