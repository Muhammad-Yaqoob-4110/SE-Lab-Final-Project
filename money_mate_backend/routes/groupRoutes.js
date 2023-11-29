const groupController = require("../controllers/groupController");
const express = require("express");
const router = express.Router();
const auth = require("../utils/auth");

// get all groups
router.get("/all_groups", groupController.getgroups);

// create group
router.post("/groups", auth.validateToken, groupController.createGroup);

// add member
router.post(
  "/groups/:groupId/members",
  auth.validateToken,
  groupController.addMembers
);

// get all groups list
router.get("/groups", auth.validateToken, groupController.getAllGroups);

router.delete("/groups/:id", auth.validateToken, groupController.deleteGroup);

module.exports = router;
