// src/services/meta/augmentRecordCollaborators.ts
import type { RecordDTO } from "../../types/record.types.js";
import type { PersonDTO } from "../../types/person.types.js";

export function augmentRecordsWithCollaborators(
  records: RecordDTO[],
  byRecord: Map<number, PersonDTO[]>
): RecordDTO[] {
  return records.map((r) => ({
    ...r,
    meta: { collaborators: byRecord.get(r.id) ?? [] },
  }));
}
