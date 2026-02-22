import express from "express";
import { loginUser } from "../controllers/loginController.js";

const router = express.Router();

// POST /api/login
router.post("/", loginUser);

export default router;
