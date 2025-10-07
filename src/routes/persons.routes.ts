import { express, idParam } from "./common.js";
import type { PersonDTO } from "../types/person.types.js";
import * as personService from "../services/persons.service.js";
import { InvalidWithError } from "../errors/RequestErrors.js";

const router = express.Router();
router.param("id", idParam);

/*Route-handler*/
// GET /api/persons - Alla personer
router.get("/", async (_req, res) => {
  const persons: PersonDTO[] = await personService.getAllPersons();
  res.json(persons);
});

// GET /api/persons/:id
router.get("/:id", async (req, res) => {
  const id = res.locals.id as number;

  // with=records,recordroles
  //String är säkrare än toString, ocn det behövs när man tar användarens inmatning
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
      throw new InvalidWithError(`Unknown include '${w}'`);
    }
  }

  // recordroles kräver records
  if (withSet.has("recordroles") && !withSet.has("records")) {
    throw new InvalidWithError("`with=recordroles` requires `with=records`");
  }

  //  // meta kräver records
  if (withSet.has("meta") && !withSet.has("records")) {
    throw new InvalidWithError("`with=meta` requires `with=records`");
  }

  if (withSet.has("meta") && !withSet.has("recordroles")) {
    throw new InvalidWithError("`with=meta` requires `with=recordroles`");
  }

  const person = await personService.getPerson(id, {
    withRecords: withSet.has("records"),
    withRecordRoles: withSet.has("recordroles"),
    withRecordRolesMeta: withSet.has("meta"),
  });

  res.json(person);
});

export default router;
