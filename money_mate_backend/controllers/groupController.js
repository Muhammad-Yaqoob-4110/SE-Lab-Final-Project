const Groups = require("../models/groupModel");
const User = require("../models/userModel");

async function getgroups(req, res) {
  try {
    const groups = await Groups.find({});
    res.json(groups);
  } catch (error) {
    console.error("Error fetching users:", error);
    throw error;
  }
}
async function getAllGroups(req, res) {
  try {
    const user = await User.findById(req.user_id);
    console.log(user.email);

    // Find groups where the user is a member
    const groups = await Groups.find({ "members.email": user.email });

    // Calculate total expense for the user "ali@gmail.com"
    let totalExpense = 0;
    groups.forEach((group) => {
      const member = group.members.find(
        (member) => member.email === user.email
      );
      if (member) {
        totalExpense += member.amount;
      }
    });

    res.status(200).json({ message: "All Groups", totalExpense, groups });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error fetching groups" });
  }
}

const createGroup = async (req, res) => {
  try {
    const user = await User.findById(req.user_id);

    const { name } = req.body;

    const newGroup = new Groups({
      name,
      createdBy: user.email,
      members: [{ email: user.email, amount: 0 }],
    });
    await newGroup.save();
    res.status(201).json({
      message: "Group created successfully",
      group: newGroup,
    });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

//  add members controller
async function addMembers(req, res) {
  try {
    const { groupId } = req.params;
    const { email } = req.body;
    const user = await User.findById(req.user_id);
    const existingUser = await User.findOne({ email: user.email });
    const newUser = await User.findOne({ email: email });
    if (!existingUser || newUser === null) {
      return res
        .status(404)
        .json({ message: "User not found in the database" });
    }
    const group = await Groups.findById(groupId);
    if (!group) {
      return res.status(404).json({ message: "Group not found" });
    }
    if (group.members.some((member) => member.email === email)) {
      return res
        .status(400)
        .json({ message: "User is already a member of the group" });
    }
    group.members.push({ email: email, amount: 0 });
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

async function deleteGroup(req, res) {
  try {
    const groupId = req.params.id;
    const deletedGroup = await Groups.findByIdAndDelete(groupId);
    if (!deletedGroup) {
      throw new Error("Group not found");
    }
    res.json({ message: "Group deleted successfully", deletedGroup });
  } catch (error) {
    console.error("Error deleting group:", error);
    res.status(500).send(error.message);
  }
}
module.exports = {
  addMembers,
  getgroups,
  getAllGroups,
  createGroup,
  deleteGroup,
};
