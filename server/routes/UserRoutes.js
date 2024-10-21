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

    //authenticate user
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

    //get users
    router.route("/").get(authenticateToken, (req, res) => {
        User.find()
        .then((users) => res.status(200).json(users))
        .catch((err) => res.status(400).json("Error: " + err));
    });

    //get user by id
    router.route("/:id").get(authenticateToken, (req, res) => {
        User.findById(req.params.id)
          .then((user) => res.status(200).json(user))
          .catch((err) => res.status(400).json("Error: " + err));
      });

    //update user by id
    router.route("/:id").put(authenticateToken, async (req, res) => {
        try {
          const updatedUser = await User.findOneAndUpdate(
            { _id: req.params.id },
            {
              $set: {
                username: req.body.username,
                email: req.body.email,
                password: req.body.password,
              },
            },
            {
              new: true,
            }
          );
          // Send the response
        res.status(200).json({ message: "Successfully updated user!" });
    } catch (err) {
        res.status(400).json("Error: " + err);
    }
    });

    router.route("/:id").delete(authenticateToken, (req, res) => {
        const { id } = req.params;
        User.findByIdAndDelete(id)
          .then(() => {
            res.status(200).json("User deleted!");
            req.io.emit('userDeleted', { id });
          })
          .catch((err) => {
            res.status(400).json("Error: " + err);
          });
      });
  

module.exports = router;