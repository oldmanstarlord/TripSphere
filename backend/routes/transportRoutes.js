import express from "express";
import { getAllTransportOptions } from "../controllers/transportController.js";

const router = express.Router();

router.get("/", getAllTransportOptions);

export default router;
