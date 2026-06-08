const express = require("express");
const router = express.Router();
const billController = require("../controllers/billController");

router.get("/", billController.getBills);
router.get("/:id", billController.getBillById);
router.post("/", billController.createBill);
router.patch("/:id", billController.updateBill);

module.exports = router;
