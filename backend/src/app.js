const express = require("express");
const cors = require("cors");
const app = express();
const productRoutes = require("./routes/productRoutes");
const clientRoutes = require("./routes/clientRoutes");
const billRoutes = require("./routes/billRoutes");
const ledgerRoutes = require("./routes/ledgerRoutes");
const priceListRoutes = require("./routes/priceListRoutes");
const errorHandler = require("./middleware/errorHandler");
const paymentRoutes = require('./routes/paymentRoutes');
const productionRoutes = require("./routes/productionRoutes");


// Middleware
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

app.use(cors(
  {
    origin: "*",
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],  //Allowed HTTP methods
    allowedHeaders: "Content-Type,Authorization" //Allowed headers 
  }
));
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
app.use("/api/bills", billRoutes);
app.use("/api/ledger", ledgerRoutes);
app.use("/api/price-lists", priceListRoutes);
app.use('/api/payments', paymentRoutes);
app.use('/api/production', productionRoutes)

// Error handling middleware
app.use(errorHandler);

// // Angular files
// app.use(express.static(path.join(__dirname, 'dist')));

// // SPA fallback
// app.get('*', (req, res) => {
//   res.sendFile(path.join(__dirname, 'dist/index.html'));
// });

module.exports = app;

