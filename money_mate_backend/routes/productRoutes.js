const express = require("express");
const router = express.Router();
const productController = require("../controllers/productController");

// create a product
router.post("/products", productController.createProduct);

// get all products
router.get("/products", productController.getAllProducts);

// update a product by id
router.put("/products/:id", productController.updateProduct);

// delete a product by id
router.delete("/products/:id", productController.deleteProduct);

module.exports = router;
