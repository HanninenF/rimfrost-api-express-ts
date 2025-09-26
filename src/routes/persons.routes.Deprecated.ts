import * as personService from "../services/persons.service.Deprecated.js";
import * as recordService from "../services/records.service.js";
import type { PersonDTO } from "../types/person.types.js";

import { PersonNotFoundError } from "../errors/NotFoundErrors.js";
import { asyncHandler, express, makeGetById } from "./common.js";
import makeGetByForeignId from "../utils/makeGetByForeignId.js";

const router = express.Router();

// GET /api/persons - Alla personer

router.get(
  "/",
  asyncHandler(async (_req, res) => {
    const persons: PersonDTO[] = await personService.getAllPersons();
    res.json(persons);
  })
);

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

// GET /api/persons/:id/records - alla skivor kopplade till personen

router.get(
  "/:id/records",
  asyncHandler(
    makeGetByForeignId(recordService.getRecordsByPersonId, {
      NotFoundError: PersonNotFoundError,
      notFoundCode: "PERSON_NOT_FOUND",
      ownerName: "Person",
    })
  )
);

// GET /api/persons/:id/with?records - En specifik person och alla skivor kopplade till personen

router.get(
  "/:id/with?records",
  asyncHandler(
    makeGetById(
      personService.getPersonWithRecords,
      PersonNotFoundError,
      "PERSON_NOT_FOUND",
      "Person"
    )
  )
);

export default router;
