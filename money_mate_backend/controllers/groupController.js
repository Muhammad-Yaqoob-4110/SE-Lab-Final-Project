const Groups = require("../models/groupModel");
const User = require("../models/userModel");

async function createGroup(req, res) {
  try {
    const { name } = req.body;

    const newGroup = new Groups({
      name,
      members: [],
      expenses: [],
    });

    // Save the new group to the database
    const savedGroup = await newGroup.save();

    res.status(201).json({
      message: "Group created successfully",
      group: savedGroup,
    });
  } catch (error) {
    console.error("Error creating group:", error);

    res.status(500).json({
      message: "Error creating group. Please try again later.",
      error: error.message,
    });
  }
}

async function addExpences(req, res) {
  try {
    const groupId = req.params.groupId;
    const { description, amount, paidBy } = req.body;

    const group = await Groups.findById(groupId);

    if (!group) {
      return res.status(404).json({ message: "Group not found" });
    }

    group.expenses.push({
      description,
      amount,
      paidBy,
    });

    const groupInfo = await group.save();

    res.json({
      message: "Expense added to the group successfully",
      group: groupInfo,
    });
  } catch (error) {
    console.error("Error adding expense to group:", error);
    res.status(500).json({
      message: "Error adding expense to group. Please try again later.",
      error: error.message,
    });
  }
}

//  add members controller
async function addMembers(req, res) {
  try {
    const { groupId, userEmail } = req.body;

    // Check if the user with the provided email exists
    const existingUser = await User.findOne({ email: userEmail });

    if (!existingUser) {
      return res
        .status(404)
        .json({ message: "User not found in the database" });
    }

    const group = await Groups.findById(groupId);

    if (!group) {
      return res.status(404).json({ message: "Group not found" });
    }

    // Check if the user is already a member of the group
    if (group.members.includes(userEmail)) {
      return res
        .status(400)
        .json({ message: "User is already a member of the group" });
    }

    // Add the user to the group
    group.members.push(userEmail);

    const groupInfo = await group.save();

    res.json({
      message: "User added to the group successfully",
      group: groupInfo,
    });
  } catch (error) {
    console.error("Error adding user to group:", error);

    res.status(500).json({
      message: "Error adding user to group. Please try again later.",
      error: error.message,
    });
  }
}

module.exports = {
  createGroup,
  addMembers,
  addExpences,
};
