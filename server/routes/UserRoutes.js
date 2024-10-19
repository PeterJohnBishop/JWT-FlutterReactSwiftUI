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

  router.route("/auth").post(async (req, res) => {
    const user = req.body;
    await User.findOne({ username: user.username }).then((u) => {
      if (!u) {
        return res.status(404).json({ message: "User not found" });
      }
      bcrypt.compare(user.password, u.password).then((match) => {
        if (match) {
          const payload = {
            id: u._id,
            username: u.username,
          };
          jwt.sign(
            payload,
            process.env.JWT_SECRET,
            { expiresIn: 86400 },
            (error, token) => {
              if (error) {
                return res.status(401).json({ message: error });
              } else {
                return res.status(200).json({
                  message: "Login Success!",
                  user: u,
                  jwt: token,
                });
              }
            }
          );
        } else {
          return res.status(409).json({
            message: "Username or password is incorrect.",
          });
        }
      });
    });
  });

module.exports = router;