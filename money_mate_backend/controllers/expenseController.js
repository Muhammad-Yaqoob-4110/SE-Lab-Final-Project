const Expense = require("../models/expenseModel");
const Groups = require("../models/groupModel");
const User = require("../models/userModel");


const createExpense = async (req, res) => {
  try {
    const { description, amount, paidBy, group } = req.body;
    if (!amount || !paidBy || !group){
      res.status(500).json({
        message: "Attribute can not be null",
      });
    }
    console.log(description, amount, paidBy, group)
    const newExpense = new Expense({ description, amount, paidBy, group });
    await newExpense.save();
    const user = await User.findById(paidBy);
    const _group = await Groups.findById(group);
    const borrow_amount = amount / _group.members.length
    const lent_amount = borrow_amount * (_group.members.length - 1)
    console.log(_group)
    _group.members.forEach(member => {
      console.log(member.email)
      if (member.email !== user.email) {
          member.amount += -borrow_amount;
      } else {
        member.amount += lent_amount;
      }
    });
    _group.save()
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
