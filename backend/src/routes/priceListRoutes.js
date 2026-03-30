const express = require("express");
const router = express.Router();
const priceListController = require("../controllers/priceListController");

router.get("/", priceListController.getAllActive);
router.get("/client/:clientId", priceListController.getByClient);
router.get("/:priceListId/items", priceListController.getItems);

module.exports = router;