import express from "express";
import type { RecordDTO } from "../types/record.types.js";
import * as recordService from "../services/records.service.js";

const router = express.Router();

//GET /api/records - Alla skivor

router.get("/", async (req, res) => {
  try {
    const records: RecordDTO[] = await recordService.getAllRecords();
    res.json(records);
  } catch (err: unknown) {
    if (err instanceof Error) {
      console.error("Error fetching records: ", err.message);
      res.status(500).json({
        err: "Failed to fetch records",
        details: err.message,
      });
    } else {
      console.error("Unknown error: ", err);
      res.status(500).json({
        err: "Failed to fetch records",
        details: "Unknown error",
      });
    }
  }
});
export default router;
