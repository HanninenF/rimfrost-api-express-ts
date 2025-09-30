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

// GET /api/persons/:id
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

    // with=records,recordroles
    const withParam = String(req.query.with ?? "");
    const withSet = new Set(
      withParam
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean)
        .map((s) => s.toLowerCase())
    );

    // validera tillåtna värden
    const allowed = new Set(["records", "recordroles", "meta"]);
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

    // recordroles kräver records
    if (withSet.has("recordroles") && !withSet.has("records")) {
      return res.status(400).json({
        err: "Request Error",
        code: "INVALID_WITH",
        details: "`with=recordroles` requires `with=records`",
        status: 400,
        route: `${req.method} ${req.originalUrl}`,
      });
    }

    //  // meta kräver records
    if (withSet.has("meta") && !withSet.has("records")) {
      return res.status(400).json({
        err: "Request Error",
        code: "INVALID_WITH",
        details: "`with=meta` requires `with=records`",
        status: 400,
        route: `${req.method} ${req.originalUrl}`,
      });
    }
    // (om din meta använder roller: lägg även in detta)
    if (withSet.has("meta") && !withSet.has("recordroles")) {
      return res.status(400).json({
        err: "Request Error",
        code: "INVALID_WITH",
        details: "`with=meta` requires `with=recordroles`",
        status: 400,
        route: `${req.method} ${req.originalUrl}`,
      });
    }

    const person = await personService.getPerson(id, {
      withRecords: withSet.has("records"),
      withRecordRoles: withSet.has("recordroles"),
      withRecordRolesMeta: withSet.has("meta"),
    });

    res.json(person);
  })
);

export default router;
