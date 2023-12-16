const express = require("express");
const app = express();
const port = 4110;
const hostname = "0.0.0.0";
const cors = require("cors");
const bodyparser = require("body-parser");
require("./utils/db");
const userRouter = require("./routes/userRoutes");
const groupRouter = require("./routes/groupRoutes");
const expenseRouter = require("./routes/expenseRoutes");

app.get("/", (req, res) => {
  res.send("Hello, World!");
});

//Middlewares
app.use(bodyparser.json());
app.use(cors());

// User API
app.use("/api/users", userRouter);

// Group API
app.use("/api", groupRouter);

// Expense API
app.use("/api/expenses", expenseRouter);

app.get("/welcome", (req, res) => {
  res.send("<h1>Welcome Ali Ahmed</h1>");
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
// node behavious = asyncrouns
