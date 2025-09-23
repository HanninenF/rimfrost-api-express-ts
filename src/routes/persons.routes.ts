import express from "express";

import * as personservice from "../services/persons.service.js";
import type { PersonDTO } from "../types/person.types.js";

const router = express.Router();

// GET /api/persons - Alla personer

router.get("/", async (req, res) => {
  try {
    const persons: PersonDTO[] = await personservice.getAllpersons();
    res.json(persons);
  } catch (err: unknown) {
    if (err instanceof Error) {
      console.error("Error fetching persons: ", err.message);
      res.status(500).json({
        err: "Failed to fetch persons",
        details: err.message,
      });
    } else {
      console.error("Unknown error: ", err);
      res.status(500).json({
        err: "Failed to fetch persons",
        details: "Unknown error",
      });
    }
  }
});

export default router;
