const express = require("express");
const router = express.Router();
const userController = require("../../controllers/authenticationControllers/userController");

// create a user
router.post("/users", userController.createUser);

// // get a user by email
// router.get("/users/:email", userController.getUserByEmail);

// login api for the user.
router.post("/users/login", userController.loginUser);

// // get all products
// router.get("/products", productController.getAllProducts);

// update a user by id
router.put("/users/:email", userController.updateUser);

// // delete a product by id
// router.delete("/products/:id", productController.deleteProduct);

module.exports = router;
