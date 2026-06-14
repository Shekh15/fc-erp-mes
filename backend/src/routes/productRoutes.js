const express = require("express");
const router = express.Router();
const productController = require("../controllers/productController");

router.get("/", productController.getProducts);
router.get("/available", productController.getAvailableProducts);
router.get("/stock", productController.getStockList);

router.post("/", productController.createProduct);

// router.put("/:id", productController.updateProduct);
router.put("/adjust-stock", productController.adjustStock);

module.exports = router;
