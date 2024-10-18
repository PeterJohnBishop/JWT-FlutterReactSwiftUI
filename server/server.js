const express = require('express');
const mongoose = require('mongoose');
const http = require('http'); // Import HTTP module to work with Socket.IO
const { Server } = require('socket.io');
const bodyParser = require('body-parser');
const app = express();
const port = 8080;
const server = http.createServer(app);
const io = new Server(server);
const dotenv = require("dotenv");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

dotenv.config();
// const JWT_SECRET = process.env.JWT_SECRET;

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// mongoose.connect(process.env.MONGODB_URI);
// const connection = mongoose.connection;
// connection.once("open", () => {
//   console.log("MongoDB database connection established successfully");
// });

io.on('connection', (socket) => {
    console.log('A user connected');
  
    // Handle disconnection
    socket.on('disconnect', () => {
      console.log('User disconnected');
    });
  });
  
  // Start the server
  server.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
  });