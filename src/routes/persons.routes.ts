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

    // with=records,recordRoles
    const withParam = String(req.query.with ?? "");
    const withSet = new Set(
      withParam
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean)
    );

    // validera tillåtna värden
    const allowed = new Set(["records", "recordRoles"]);
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

    // recordRoles kräver records
    if (withSet.has("recordRoles") && !withSet.has("records")) {
      return res.status(400).json({
        err: "Request Error",
        code: "INVALID_WITH",
        details: "`with=recordRoles` requires `with=records`",
        status: 400,
        route: `${req.method} ${req.originalUrl}`,
      });
    }

    const person = await personService.getPerson(id, {
      withRecords: withSet.has("records"),
      withRecordRoles: withSet.has("recordRoles"),
    });

    res.json(person);
  })
);

export default router;
