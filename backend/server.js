import express from "express";
import dotenv from "dotenv";
import cors from "cors";

import accommodationRoutes from "./routes/accommodationRoutes.js";
import transportRoutes from "./routes/transportRoutes.js";
import paymentRoutes from "./routes/paymentRoutes.js";
import flightRoutes from "./routes/flightRoutes.js";
import trainRoutes from "./routes/trainRoutes.js";
import itineraryRoutes from "./routes/itineraryRoutes.js";
import bookingRoutes from "./routes/bookingRoutes.js";
import loginRoutes from "./routes/loginRoutes.js";
import userRoutes from "./routes/userRoutes.js";
import locationRoutes from "./routes/locationRoutes.js";

// Import DB connection (ES Modules)
import connection from "./config/db.js";

// Load environment variables
dotenv.config();

// Initialize express app
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/api/users", userRoutes);
app.use("/api/locations", locationRoutes);
app.use("/api/accommodations", accommodationRoutes);
app.use("/api/transport", transportRoutes);
app.use("/api/payment", paymentRoutes);
app.use("/api/flights", flightRoutes);
app.use("/api/trains", trainRoutes);
app.use("/api/itinerary", itineraryRoutes);
app.use("/api/bookings", bookingRoutes);
app.use("/api/login", loginRoutes);

// Health check
app.get("/", (req, res) => {
  res.send("🌍 Travel Management Backend is Running 🚀");
});

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});

// Connect to database
connection.connect((err) => {
  if (err) {
    console.error("❌ Database connection failed:", err);
    return;
  }
  console.log("✅ Connected to MySQL Database");
});
