const Bill = require("../models/Bill");

exports.getBills = async (req, res, next) => {
  try {
    const bills = await Bill.getAll();
    
    const formattedBills = bills.map(b => ({
      ...b,
      paidAmount: Number(b.paidAmount),
      previousAmount: Number(b.previousAmount),
      total: Number(b.total)
    }));

    res.json(formattedBills);

  } catch (err) {
    next(err);
  }
};

exports.createBill = async (req, res, next) => {
  try {
    const userId = 1; // TODO: replace with req.user.id
    const bill = await Bill.create(req.body, userId);
    res.status(201).json(bill);
  } catch (err) {
    next(err);
  }
};

exports.updateBill = async (req, res, next) => {
  try {
    const userId = 1; // TODO: replace with req.user.id
    const bill = await Bill.update(req.params.id, req.body, userId);
    res.json(bill);
  } catch (err) {
    next(err);
  }
};