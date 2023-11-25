const express = require("express");
const router = express.Router();
const expenseController = require("../controllers/expenseController");

// create a expense
router.post("/create-expense", expenseController.createExpense);

// get all expenses of any group
router.get("/all-expense/:groupId", expenseController.getExpensesForGroup);

module.exports = router;
