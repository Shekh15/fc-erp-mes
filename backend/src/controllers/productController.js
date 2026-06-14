const Product = require("../models/Product");

exports.getProducts = async (req, res, next) => {
  try {
    const products = await Product.getAll();

    const formattedProducts = products.map((product) => ({
      ...product,
      price: product.price !== null ? Number(product.price) : 0,
    }));

    res.json(formattedProducts);
  } catch (err) {
    next(err);
  }
};

exports.getAvailableProducts = async (req, res, next) => {
  try {
    const products = await Product.getAvailableProducts();

    const formattedProducts = products.map((product) => ({
      ...product,
      price: product.price !== null ? Number(product.price) : 0,
      current_stock:
        product.current_stock !== null
          ? Number(product.current_stock)
          : 0,
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

// exports.updateProduct = async (req, res, next) => {
//   try {
//     const id = req.params.id;
//     const updated = await Product.update(id, req.body);
//     res.json(updated);
//   } catch (err) {
//     next(err);
//   }
// };

// ================= STOCK LIST =================
exports.getStockList = async (req, res) => {
  try {
    const data = await Product.getStockList();

    res.status(200).json(data);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

// ================= ADJUST STOCK =================
exports.adjustStock = async (req, res) => {
  try {
    const result = await Product.adjustStock(req.body);

    res.status(200).json(result);
  } catch (error) {
    console.error(error);

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};
