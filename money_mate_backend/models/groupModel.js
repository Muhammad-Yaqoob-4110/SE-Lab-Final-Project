const mongoose = require("mongoose");

const groupSchema = mongoose.Schema(
  {
    name: String,
    members: [String], // List of member emails
    expenses: [
      {
        description: String,
        amount: Number,
        paidBy: String,
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Groups", groupSchema);
