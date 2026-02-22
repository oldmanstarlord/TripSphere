import express from "express";
import { getItineraryByDestination } from "../controllers/itineraryController.js";

const router = express.Router();

router.get("/:destination", getItineraryByDestination);

export default router;
