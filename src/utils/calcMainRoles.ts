import type { RecordDTO } from "../types/record.types.js";
import type { RoleDTO } from "../types/role.types.js";

export function calcMainRoles(records: RecordDTO[]): RoleDTO[] {
  // --- Main role (den mest frekventa rollen) ---
  const roleFrequency = new Map<number, { role: RoleDTO; count: number }>();
  for (const rec of records) {
    for (const role of rec.role ?? []) {
      const entry = roleFrequency.get(role.id);
      if (entry) {
        entry.count++;
      } else {
        roleFrequency.set(role.id, { role, count: 1 });
      }
    }
  }

  if (roleFrequency.size > 0) {
    const entries = [...roleFrequency.values()];
    const maxCount = Math.max(...entries.map((e) => e.count));

    // alla kandidater som delar högsta count
    const candidates = entries
      .filter((e) => e.count === maxCount)
      .sort((a, b) => a.role.role_title.localeCompare(b.role.role_title));

    return candidates.map((e) => e.role);
  }
  return [];
}
