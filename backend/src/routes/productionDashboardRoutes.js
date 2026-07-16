const express = require("express");

const router = express.Router();

const productionDashboardController = require("../controllers/productionDashboardController");

router.get("/", productionDashboardController.getDashboard);

module.exports = router;
