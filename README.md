# animated-barnacle

This is a starter project to quickly launch a full stack application on multiple platforms.  

# Server Components

Node -> Express
JWT
Socket.IO
MongoDB -> Mongoose

The Node Express server implements an example API for user authentication with JWT access control. Backend data can be saved through MongoDB using Mongoose. Realtime event management is done through Socket.IO.

For multiple platforms multiple HTTP servers listening on different ports for requests and Socket.IO events.

CORS setup to allow access for testing from the default React app, Flutter via a dynamic port selection, and SwiftUI using the simulator IP. 

* to find your ip:
    - change "en0" to whichever interface matches your machine. en0 is the wifi on my machine and my hard-wire is en3. Do an "ifconfig -a" in Terminal to get the list of all of your adapters and see which is which for your machine
    - run 'ipconfig getifaddr en0'

## Starting the Server

install dependencies in the root directory of your server with 'npm i'

make neccessary adjustments to CORS policy described above

* add a .env file to the root directory of your server with the following: 

    MONGODB_URI={your mongodb URI connection string}
    SERVER_PORT_SWIFT={port for the swiftUI app}
    SERVER_PORT_FLUTTER={port for the Flutter app}
    SERVER_PORT_REACT={port for the React app}
    JWT_SECRET={your secret of choice}

start the server with 'nodemon server.js'

# SwiftUI

* On authentcation the JWT is saved to UserDefaults.

# Flutter

* On authentication the Flutter app makes use of the dependency 'shared_preferences' to save the JWT to local storage or its equivalent depending on the environment.

# React

* On authentication the JWT is saved the local storage.


