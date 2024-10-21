const express = require('express');
const mongoose = require('mongoose');
const http = require('http'); // Import HTTP module to work with Socket.IO
const { Server } = require('socket.io');
const bodyParser = require('body-parser');
const app = express();
const dotenv = require("dotenv");
const cors = require('cors');
// const server = http.createServer(app);
// const io = new Server(server);

dotenv.config();
// const port = process.env.SERVER_PORT_1;

app.use(bodyParser.json());

app.use(cors());
//dev only to allow dynamic ports for flutter app
const allowedOrigins = [
  /^http:\/\/localhost(:\d+)?$/,     // Flutter App
  'http://192.168.0.165',            // XCode Simulator
  'http://localhost:3000',
  'http://192.168.0.165:3000'
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

const ports = [process.env.SERVER_PORT_SWIFT, process.env.SERVER_PORT_REACT, process.env.SERVER_PORT_FLUTTER];

const configureSocketIO = (io) => {
  io.on('connection', (socket) => {
    console.log('A user connected on port:', io.httpServer.address().port);

    socket.on('Connected', (data) => {
      console.log(`Data received on port ${io.httpServer.address().port}:`, data);
    });

    socket.on('disconnect', () => {
      console.log(`User disconnected from port ${io.httpServer.address().port}`);
    });
  });
};

  ports.forEach((port) => {
    const server = http.createServer(app); // Create a new HTTP server
    const io = new Server(server, {
      cors: {
        origin: allowedOrigins, // Allow React app origin
        methods: ["GET", "POST"], // Allowable methods
        credentials: true         // Enable credentials if needed (like cookies)
      }
    }); // Attach a new Socket.IO instance to the server
  
    configureSocketIO(io); // Attach the Socket.IO event handlers
  
    server.listen(port, () => {
      console.log(`Server running with Socket.IO at http://localhost:${port}/`);
    });
  });
  