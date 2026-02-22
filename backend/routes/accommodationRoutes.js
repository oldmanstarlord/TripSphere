import express from "express";
import { getAccommodations } from "../controllers/accommodationController.js";

const router = express.Router();

router.get("/", getAccommodations);

export default router;
