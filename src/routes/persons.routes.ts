import { asyncHandler, express } from "./common.js";
import type { PersonDTO } from "../types/person.types.js";
import * as personService from "../services/persons.service.js";

const router = express.Router();

// GET /api/persons - Alla personer

router.get(
  "/",
  asyncHandler(async (_req, res) => {
    const persons: PersonDTO[] = await personService.getAllPersons();
    res.json(persons);
  })
);

// persons.routes.ts
router.get(
  "/:id",
  asyncHandler(async (req, res) => {
    const id = Number.parseInt(req.params.id ?? "", 10);
    if (!Number.isFinite(id)) {
      return res.status(400).json({
        err: "Request Error",
        code: "INVALID_ID",
        status: 400,
        route: `${req.method} ${req.originalUrl}`,
      });
    }

    // with=records,roles
    const withParam = String(req.query.with ?? "");
    const withSet = new Set(
      withParam
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean)
    );

    // validera tillåtna värden
    const allowed = new Set(["records", "roles"]);
    for (const w of withSet) {
      if (!allowed.has(w)) {
        return res.status(400).json({
          err: "Request Error",
          code: "INVALID_WITH",
          details: `Unknown include '${w}'`,
          status: 400,
          route: `${req.method} ${req.originalUrl}`,
        });
      }
    }

    const person = await personService.getPerson(id, {
      withRecords: withSet.has("records"),
      withRoles: withSet.has("roles"),
    });

    res.json(person);
  })
);

export default router;
