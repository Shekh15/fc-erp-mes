const Client = require("../models/Client");

exports.getClients = async (req, res, next) => {
  try {
    const clients = await Client.getAll();
    res.json(clients);
  } catch (err) {
    next(err);
  }
};

exports.createClient = async (req, res, next) => {
  try {
    const client = await Client.create(req.body);
    res.status(201).json(client);
  } catch (err) {
    next(err);
  }
};
