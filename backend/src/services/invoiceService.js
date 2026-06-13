const fs = require("fs");
const path = require("path");

const renderInvoice = require("../utils/renderInvoice");
const generateInvoicePDF = require("../utils/generateInvoicePDF");
const Bill = require("../models/Bill");

exports.generateAndSaveInvoice = async (bill) => {

  const html = await renderInvoice(bill);

  const pdf = await generateInvoicePDF(html);

  const invoiceDir = path.join(
    process.cwd(),
    "uploads",
    "invoices"
  );

  if (!fs.existsSync(invoiceDir)) {
    fs.mkdirSync(invoiceDir, { recursive: true });
  }

  const fileName = `bill-${bill.id}.pdf`;

  const pdfPath = path.join(invoiceDir, fileName);

  fs.writeFileSync(pdfPath, pdf);

  await Bill.updatePdfPath(
    bill.id,
    `uploads/invoices/${fileName}`
  );

  return pdfPath;
};