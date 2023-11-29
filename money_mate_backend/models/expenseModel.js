const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const expenseSchema = new Schema(
  {
    description: String,
    amount: Number,
    paidBy: String,
    group: mongoose.Schema.Types.ObjectId,
    date: { type: Date, default: Date.now },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Expenses", expenseSchema);
