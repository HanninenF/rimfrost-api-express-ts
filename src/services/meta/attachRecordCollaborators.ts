import prisma from "../../db/prismaClient.js";
import type { PersonDTO } from "../../types/person.types.js";

export async function attachRecordCollaborators(
  personDTO: PersonDTO
): Promise<void> {
  const recordIds = (personDTO.records ?? []).map((r) => r.id);
  if (recordIds.length === 0) return;

  const credits = await prisma.release_credit.findMany({
    where: { release_id: { in: recordIds } },
    include: { person: true },
  });

  // release_id -> (person_id -> PersonDTO)
  const byRecord = new Map<number, Map<number, PersonDTO>>();

  for (const c of credits) {
    if (c.person_id === personDTO.id) continue; // hoppa över huvudpersonen

    const collaborators: PersonDTO = {
      id: c.person.id,
      first_name: c.person.first_name,
      alias: c.person.alias,
      last_name: c.person.last_name,
      ipi_number: c.person.ipi_number,
    };

    const bucket = byRecord.get(c.release_id) ?? new Map<number, PersonDTO>();
    bucket.set(collaborators.id, collaborators); // dedupe per person
    byRecord.set(c.release_id, bucket);
  }

  personDTO.records = (personDTO.records ?? []).map((r) => ({
    ...r,
    meta: {
      collaborators: Array.from(byRecord.get(r.id)?.values() ?? []),
    },
  }));
}
