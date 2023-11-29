const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");
const auth = require("../utils/auth");

// get all users
router.get("", userController.getAllUsers);

// create a user
router.post("", userController.createUser);

// login api for the user.
router.post("/login", userController.loginUser);

// get user by id
router.get("/:id", auth.validateToken, userController.getUser)

// update a user by email
router.put("/:email", auth.validateToken, userController.updateUser);

module.exports = router;
