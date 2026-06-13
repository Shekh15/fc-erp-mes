const express = require("express");
const router = express.Router();

const ProductionController = require("../controllers/productionController");

router.get("/", ProductionController.getAll);

router.post("/", ProductionController.create);

router.put("/:id", ProductionController.update);

module.exports = router;
