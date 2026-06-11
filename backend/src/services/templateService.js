const ejs = require("ejs");
const path = require("path");

exports.renderInvoice = async (bill) => {

  const templatePath = path.join(
    process.cwd(),
    "src",
    "templates",
    "invoiceTemplate.ejs"
  );

  return await ejs.renderFile(templatePath, {
    bill
  });

};