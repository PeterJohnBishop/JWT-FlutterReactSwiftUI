const express = require('express');
const mongoose = require('mongoose');
const http = require('http'); // Import HTTP module to work with Socket.IO
const { Server } = require('socket.io');
const bodyParser = require('body-parser');
const app = express();
const server = http.createServer(app);
const io = new Server(server);
const dotenv = require("dotenv");
const cors = require('cors');

dotenv.config();
const port = process.env.SERVER_PORT;

app.use(bodyParser.json());

app.use(cors());
//dev only to allow dynamic ports for flutter app
const allowedOrigins = [
  /^http:\/\/localhost(:\d+)?$/,     // Allow localhost with optional port
  'http://192.168.0.165',            // Add specific IP address
  // Add more IPs or domains as needed
];

const corsOptions = {
  origin: (origin, callback) => {
    if (!origin) {
      // Allow requests with no origin (like mobile apps or curl requests)
      callback(null, true);
    } else if (allowedOrigins.some(o => typeof o === 'string' ? o === origin : o.test(origin))) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
};
app.use(cors(corsOptions));

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

mongoose.connect(process.env.MONGODB_URI);
const connection = mongoose.connection;
connection.once("open", () => {
  console.log("MongoDB database connection established successfully");
});

const UserRouter = require("./routes/UserRoutes");
app.use("/users", UserRouter);

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