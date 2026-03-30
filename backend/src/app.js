const express = require("express");
const cors = require("cors");
const app = express();
const productRoutes = require("./routes/productRoutes");
const clientRoutes = require("./routes/clientRoutes");
const stockRoutes = require("./routes/stockRoutes");
const billRoutes = require("./routes/billRoutes");
const ledgerRoutes = require("./routes/ledgerRoutes");
const priceListRoutes = require("./routes/priceListRoutes");
const errorHandler = require("./middleware/errorHandler");
const paymentRoutes = require('./routes/paymentRoutes');


// Middleware
app.use(cors());
app.use(express.json());

// ✅ Root health check
app.get("/", (req, res) => {
  res.json({
    status: "OK",
    message: "FC ERP Backend is running 🚀"
  });
});

// Routes
app.use("/api/products", productRoutes);
app.use("/api/clients", clientRoutes);
app.use("/api/stocks", stockRoutes);
app.use("/api/bills", billRoutes);
app.use("/api/ledger", ledgerRoutes);
app.use("/api/price-lists", priceListRoutes);
app.use('/api/payments', paymentRoutes);

// Error handling middleware
app.use(errorHandler);

module.exports = app;

