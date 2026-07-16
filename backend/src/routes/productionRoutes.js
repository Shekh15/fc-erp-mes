const express = require("express");
const router = express.Router();

const ProductionController = require("../controllers/productionController");

router.get("/", ProductionController.getAll);

router.post("/", ProductionController.create);

router.post("/production/bulk", ProductionController.createBulk);

router.put("/:id", ProductionController.update);

module.exports = router;
