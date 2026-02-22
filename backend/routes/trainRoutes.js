import express from "express";
import { getTrains } from "../controllers/trainController.js";

const router = express.Router();

router.get("/", getTrains);

export default router;
