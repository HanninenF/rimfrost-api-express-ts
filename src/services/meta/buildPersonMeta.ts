import type { PersonDTO, PersonMetaDTO } from "../../types/person.types.js";
import { calcMainRoles } from "../../utils/calcMainRoles.js";
import { calcRoleCount } from "../../utils/calcRoleCount.js";
import { calcYearsActive } from "../../utils/calcYearsActive.js";

// Bygg meta-data för en person
export function buildPersonMeta(person: PersonDTO): PersonMetaDTO {
  const records = person.records ?? [];

  // --- Years active ---
  const years_active = calcYearsActive(records);

  // --- Record count ---
  const recordCount = records.length;

  // --- Role count (unika roller över alla records) ---
  const roleCount = calcRoleCount(records);

  // --- Main roles (de mest frekventa rollerna) ---
  const mainRoles = calcMainRoles(records);

  return {
    years_active,
    recordCount,
    roleCount,
    mainRoles,
    mainRolesCount: mainRoles.length,
  };
}

