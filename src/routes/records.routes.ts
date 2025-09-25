import express from "express";
import type { RecordDTO } from "../types/record.types.js";
import * as recordService from "../services/records.service.js";
import { asyncHandler } from "../utils/asyncHandler.js";
import idParam from "../middleware/idParam.js";
import makeGetById from "../utils/makeGetById.js";
import { RecordNotFoundError } from "../errors/NotFoundErrors.js";

const router = express.Router();

//GET /api/records - Alla skivor

router.get(
  "/",
  asyncHandler(async (_req, res) => {
    const records: RecordDTO[] = await recordService.getAllRecords();
    res.json(records);
  })
);

router.param("id", idParam);

// GET /api/records/:id
router.get(
  "/:id",
  asyncHandler(
    makeGetById(
      recordService.getRecordById,
      RecordNotFoundError,
      "RECORD_NOT_FOUND",
      "Record"
    )
  )
);

export default router;
