const Bill = require("../models/Bill");
const PDFDocument = require("pdfkit");
const { renderInvoice } = require("../services/templateService");
const { generateInvoicePDF } = require("../services/pdfService");
const fs = require("fs");
const path = require("path");

exports.getBills = async (req, res, next) => {
  try {
    const bills = await Bill.getAll();

    const formattedBills = bills.map((b) => ({
      ...b,
      paidAmount: Number(b.paidAmount),
      previousAmount: Number(b.previousAmount),
      total: Number(b.total),
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
      message: err.message,
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

exports.downloadPDF = async (req, res) => {
  const billId = req.params.id;

  const bill = await Bill.getById(billId);

  

  if (!bill) {
    return res.status(404).json({
      message: "Bill not found",
    });
  }

  const html = await renderInvoice(bill);

  const pdf = await generateInvoicePDF(html);

  // Create uploads/invoices if it doesn't exist
  const invoiceDir = path.join(process.cwd(), "uploads", "invoices");

  if (!fs.existsSync(invoiceDir)) {
    fs.mkdirSync(invoiceDir, { recursive: true });
  }

  const pdfPath = path.join(invoiceDir, `bill-${bill.id}.pdf`);

  fs.writeFileSync(pdfPath, pdf);

  res.set({
    "Content-Type": "application/pdf",
    "Content-Disposition": `attachment; filename=bill-${billId}.pdf`,
  });

  res.send(pdf);
};
