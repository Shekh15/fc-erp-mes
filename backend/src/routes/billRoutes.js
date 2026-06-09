const express = require("express");
const router = express.Router();
const BillController = require("../controllers/billController");

router.get("/", BillController.getBills);
router.get("/:id", BillController.getBillById);
router.post("/", BillController.createBill);
router.patch("/:id", BillController.updateBill);
router.get("/:id/history", BillController.getBillHistory);
router.get("/version/:id", BillController.getBillVersionById);

module.exports = router;
