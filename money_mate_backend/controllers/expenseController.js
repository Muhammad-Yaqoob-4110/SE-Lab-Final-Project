const Expense = require("../models/expenseModel");
const createExpense = async (req, res) => {
  try {
    const { description, amount, paidBy, group } = req.body;
    const newExpense = new Expense({ description, amount, paidBy, group });
    await newExpense.save();
    res
      .status(201)
      .json({ message: "Expense Written Successfully", newExpense });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const getExpensesForGroup = async (req, res) => {
  try {
    const expenses = await Expense.find({ group: req.params.groupId });
    res.json({ message: "All Expenses", expenses });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  createExpense,
  getExpensesForGroup,
};
