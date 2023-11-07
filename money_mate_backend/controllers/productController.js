const Product = require("../models/product");

// Create a Product
async function createProduct(req, res) {
  try {
    console.log(req.body);
    const newproduct = await Product.create(req.body);
    res.status(201).json(newproduct);
  } catch (error) {
    res.status(500).json({ error: error });
  }
}

// Update a product by Id
async function updateProduct(req, res) {
  try {
    const { id } = req.params;
    const updatedProduct = await Product.findByIdAndUpdate(id, req.body, {
      new: true,
    });
    res.json(updatedProduct);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

// Get all products
async function getAllProducts(req, res) {
  try {
    const products = await Product.find();
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

// Delete a product by Id
async function deleteProduct(req, res) {
  try {
    const { id } = req.params;
    await Product.findByIdAndRemove(id);
    res.sendStatus(204);
  } catch (err) {
    res.sendStatus(500).json({ error: err.message });
  }
}
module.exports = {
  createProduct,
  getAllProducts,
  updateProduct,
  deleteProduct,
};
