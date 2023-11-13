const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

// create a user
router.post("/users", userController.createUser);

// login api for the user.
router.post("/users/login", userController.loginUser);

// update a user by id
router.put("/users/:email", userController.updateUser);

module.exports = router;
