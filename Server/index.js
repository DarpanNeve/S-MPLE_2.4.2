// server.js
const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const { handleConnection } = require("./socketHandler");

const PORT = process.env.PORT || 80;

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});
app.use(express.static(__dirname));
io.use((socket, next) => {
  if (socket.handshake.query && socket.handshake.query.callerId) {
    socket.user = socket.handshake.query.callerId;
    next();
  } else {
    next(new Error("Missing callerId"));
  }
});

io.on("connection", handleConnection);

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
