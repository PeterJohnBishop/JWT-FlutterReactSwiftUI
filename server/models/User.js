const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const userSchema = new Schema(
  {
    username: {
      type: String,
      required: [true, "Your username is required"],
      unique: true, // Ensure unique usernames
      trim: true,   // Trim whitespace
    },
    email: {
      type: String,
      required: [true, "Your email address is required"],
      unique: true, // Ensure unique emails
      match: [/.+@.+\..+/, "Must match an email address!"], // Simple regex for email validation
    },
    password: {
      type: String,
      required: [true, "Your password is required"],
      minlength: 5, // Minimum password length
    },
    avatar: {
      type: String,
      required: false
    },
    uploads: {
      type: [String], // Array of user IDs (or names/emails)
      required: false
    },
    longitude: {
      type: Number,
      required: false
    }, 
    latitude: {
      type: Number,
      required: false
    },
    friends: {
        type: [String],
        required: false
    }
  },
  { timestamps: true } // Adds createdAt and updatedAt timestamps automatically
);

const User = mongoose.model("User", userSchema);

module.exports = User;