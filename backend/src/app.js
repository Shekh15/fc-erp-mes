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
// app.use(cors(
//   {
//     origin: "*", Allow all origins (for development; restrict in production)
//     origin: [
//       "http://localhost:4200",
//       "http://localhost:4201", for fallback
//       "http://localhost:3000", for serve while on development
//       //Add production frontend URL here
//       "https://your-frontend-domain.com"
//     ], Allowed origins

//     methods: "GET,POST,PUT,DELETE",  Allowed HTTP methods
//     allowedHeaders: "Content-Type,Authorization" Allowed headers 
//   }
// ));
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

