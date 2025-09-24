import express from "express";

import * as personService from "../services/persons.service.js";
import type { PersonDTO } from "../types/person.types.js";

const router = express.Router();

// GET /api/persons - Alla personer

router.get("/", async (req, res) => {
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
});

router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const person = await personService.getPersonById(parseInt(id, 10));

    if (!person) {
      return res.status(404).json({ error: "Person not found" });
    }
    res.json(person);
  } catch (err) {
    if (err instanceof Error) {
      console.error("Error fetching person: ", err.message);
      res
        .status(500)
        .json({ error: "Failed to fetch person", details: err.message });
    } else {
      console.error("unknown error: ", err);
      res.status(500).json({
        error: "Failed to fetch person",
        details: "unknown error",
      });
    }
  }
});

export default router;
