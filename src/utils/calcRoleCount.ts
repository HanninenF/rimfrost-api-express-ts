import type { RecordDTO } from "../types/record.types.js";

export function calcRoleCount(records: RecordDTO[]): number {
  // --- Role count (unika roller över alla records) ---
  /*skapa en role_ids Set för att samla alla role_ids 
  för varje records-element kommer vi åt roll-arrayen som innehåller flera rollobjekt och där kan vi plocka ut id och lägga in i vår set */
  const role_ids = new Set<number>();
  for (const rec of records) {
    for (const role of rec.role ?? []) {
      role_ids.add(role.id);
    }
  }

  return role_ids.size;
}
