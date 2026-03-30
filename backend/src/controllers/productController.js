const Product = require("../models/Product");

exports.getProducts = async (req, res, next) => {
  try {
    const products = await Product.getAll();

    const formattedProducts = products.map(product => ({
      ...product,
      price: product.price !== null ? Number(product.price) : 0
    }));

    res.json(formattedProducts);

  } catch (err) {
    next(err);
  }
};

exports.createProduct = async (req, res, next) => {
  try {
    const product = await Product.create(req.body);
    res.status(201).json(product);
  } catch (err) {
    next(err);
  }
};

exports.updateProduct = async (req, res, next) => {
  try {
    const id = req.params.id;
    const updated = await Product.update(id, req.body);
    res.json(updated);
  } catch (err) {
    next(err);
  }
};
