const Payment = require("../models/Payment");

exports.getPayments = async (req, res, next) => {
  try {
    const payments = await Payment.getAll();
    res.json(payments);
  } catch (err) {
    next(err);
  }
};

exports.createPayment = async (req, res, next) => {
  try {
    const userId = 1; // TODO replace with auth later
    const payment = await Payment.create(req.body, userId);
    res.status(201).json(payment);
  } catch (err) {
    next(err);
  }
};