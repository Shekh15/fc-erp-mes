const Bill = require("../models/Bill");
const PDFDocument = require('pdfkit');

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

exports.getBillById = async (req, res, next) => {
  try {
    const bill = await Bill.getById(req.params.id);

    res.json(bill);

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

exports.getBillHistory = async (req, res) => {
  try {
    const result = await Bill.getBillHistory(req.params.id);
    res.json(result);
  } catch (err) {
    res.status(500).json({
      message: err.message
    });
  }
};

exports.getBillVersionById = async (req, res, next) => {
  try {
    const bill = await Bill.getVersionById(req.params.id);

    res.json(bill);

  } catch (err) {
    next(err);
  }
};


exports.downloadInvoice = async (req, res) => {

    const billId = req.params.id;

    console.log(`Generating PDF for Bill ID: ${billId}`);

    const bill = await Bill.getById(billId);

    const doc = new PDFDocument();

    res.setHeader(
        'Content-Type',
        'application/pdf'
    );

    res.setHeader(
        'Content-Disposition',
        `attachment; filename=Invoice-${billId}.pdf`
    );

    doc.pipe(res);

    doc.fontSize(20)
       .text('First Choice Bakery');

    doc.moveDown();

    doc.text(`Customer: ${bill.clientName}`);
    doc.text(`Invoice No: ${bill.id}`);
    doc.text(`Date: ${bill.entry_date}`);

    doc.moveDown();

    bill.items.forEach(item => {

        doc.text(
            `${item.productName}
             Qty:${item.qty}
             Price:${item.unitPrice}
             Total:${item.total}`
        );

    });

    doc.moveDown();

    doc.text(`Grand Total: ₹ ${bill.total}`);

    doc.end();
};