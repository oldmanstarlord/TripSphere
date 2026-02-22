import express from "express";
import { confirmBooking } from "../controllers/paymentController.js";

const router = express.Router();

// Route: POST /api/payment
router.post("/", confirmBooking);

export default router;
