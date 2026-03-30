const express = require("express");
const router = express.Router();
const ledgerController = require("../controllers/ledgerController");

router.get("/:clientId", ledgerController.getClientLedger);
router.get("/client/:clientId/balance", ledgerController.getClientBalance);

module.exports = router;