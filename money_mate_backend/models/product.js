const mongoose = require("mongoose");

const productSchema = mongoose.Schema(
  {
    name: String,
    dis: String,
    price: Number,
  },
  { timestamps: true } // created at and updated at will be managed automatically
);

module.exports = mongoose.model("Products", productSchema); // table name & schema
