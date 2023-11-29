const express = require("express");
const router = express.Router();
const expenseController = require("../controllers/expenseController");

// create a expense
router.post("", expenseController.createExpense);

// get all expenses of any group
router.get("/:groupId", expenseController.getExpensesForGroup);

module.exports = router;
