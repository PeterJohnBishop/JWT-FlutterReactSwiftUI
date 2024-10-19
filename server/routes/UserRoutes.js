const router = require("express").Router();
const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const authenticateToken = require("../utils/jwtVerify");

//create user
router.route('/create').post( async (req, res) => {
    try {
        req.body.password = await bcrypt.hash(req.body.password, 10);
        const newUser = new User(req.body); // Create new User instance from request body
        const savedUser = await newUser.save(); // Save to MongoDB
        res.status(200).json(savedUser);
      } catch (error) {
        res.status(400).json({ message: 'Error creating user', error: error.message });
      }
  });

module.exports = router;