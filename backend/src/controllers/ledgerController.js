const Ledger = require("../models/Ledger");

exports.getClientLedger = async (req, res, next) => {
  try {
    const ledger = await Ledger.getClientLedger(req.params.clientId);
    res.json(ledger);
  } catch (err) {
    next(err);
  }
};

exports.getClientBalance = async (req, res, next) => {
  try {
    const balance = await Ledger.getClientBalance(req.params.clientId);
    res.json({ balance });
  } catch (err) {
    next(err);
  }
};