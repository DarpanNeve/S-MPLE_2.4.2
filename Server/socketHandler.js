// socketHandler.js
const handleConnection = (socket) => {
  console.log(`${socket.user} connected`);

  socket.join(socket.user);

  socket.on("makeCall", async (data) => {
    try {
      const { calleeId, sdpOffer } = data;
      socket.to(calleeId).emit("newCall", {
        callerId: socket.user,
        sdpOffer,
      });
    } catch (error) {
      console.error("Error in makeCall:", error);
    }
  });

  socket.on("answerCall", async (data) => {
    try {
      const { callerId, sdpAnswer } = data;
      socket.to(callerId).emit("callAnswered", {
        callee: socket.user,
        sdpAnswer,
      });
    } catch (error) {
      console.error("Error in answerCall:", error);
    }
  });

  socket.on("IceCandidate", async (data) => {
    try {
      const { calleeId, iceCandidate } = data;
      socket.to(calleeId).emit("IceCandidate", {
        sender: socket.user,
        iceCandidate,
      });
    } catch (error) {
      console.error("Error in IceCandidate:", error);
    }
  });
};

module.exports = { handleConnection };
