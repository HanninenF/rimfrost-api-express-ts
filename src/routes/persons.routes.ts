import express from "express";
import { asyncHandler } from "../utils/asyncHandler.js";

import * as personService from "../services/persons.service.js";
import type { PersonDTO } from "../types/person.types.js";

import { HttpError } from "../utils/HttpError.js";
import { PersonNotFoundError } from "../errors/PersonNotFoundError.js";

const router = express.Router();

// GET /api/persons - Alla personer

router.get(
  "/",
  asyncHandler(async (_req, res) => {
    const persons: PersonDTO[] = await personService.getAllPersons();
    res.json(persons);
  })
);
/* router.get("/", async (req, res) => {
  try {
    const persons: PersonDTO[] = await personService.getAllPersons();
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
}); */

router.get(
  "/:id",
  asyncHandler(async (req, res) => {
    const { id } = req.params;
    if (!id) {
      throw new HttpError(400, "Missing person id", "MISSING_ID");
    }
    try {
      const person = await personService.getPersonById(parseInt(id, 10));
      res.json(person);
    } catch (err) {
      if (err instanceof PersonNotFoundError) {
        throw new HttpError(404, err.message, "PERSON_NOT_FOUND");
      }
      throw err;
    }
  })
);

export default router;
