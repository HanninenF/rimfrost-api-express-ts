import express from "express";
import { asyncHandler } from "../utils/asyncHandler.js";

import * as personService from "../services/persons.service.js";
import type { PersonDTO } from "../types/person.types.js";

import { PersonNotFoundError } from "../errors/NotFoundErrors.js";
import idParam from "../middleware/idParam.js";
import makeGetById from "../utils/makeGetById.js";

const router = express.Router();

// GET /api/persons - Alla personer

router.get(
  "/",
  asyncHandler(async (_req, res) => {
    const persons: PersonDTO[] = await personService.getAllPersons();
    res.json(persons);
  })
);

router.param("id", idParam);

// GET /api/persons/:id
router.get(
  "/:id",
  asyncHandler(
    makeGetById(
      personService.getPersonById,
      PersonNotFoundError,
      "PERSON_NOT_FOUND",
      "Person"
    )
  )
);

export default router;
