const groupController = require("../controllers/groupController");
const router = require("./userRoutes");

// creatae group
router.post("/create-group", groupController.createGroup);

// add member
router.post("/add-member", groupController.addMembers);

// Add an expense to a group
router.post("/add-expense/:groupId", groupController.addExpences);

module.exports = router;