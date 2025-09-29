// persons.service.ts
import { PersonNotFoundError } from "../errors/NotFoundErrors.js";
import * as personData from "../data/persons.data.js";
import * as collabData from "../data/collaborators.data.js";
import { buildPersonMeta } from "./meta/buildPersonMeta.js";
import { augmentRecordsWithCollaborators } from "./meta/index.js";
import type { Person, PersonDTO } from "../types/person.types.js";
import type { RecordDTO } from "../types/record.types.js";

type Options = {
  withRecords?: boolean;
  withRecordRoles?: boolean;
  withRecordRolesMeta?: boolean;
};

/* // Validera include-objektet så att felstavningar fångas av kompilatorn
// ----- include-objekt som värden (ingen Prisma.validator behövs)
const includeCredits = {
  release_credit: { include: { record: true } },
} as const;

const includeCreditsAndRoles = {
  release_credit: {
    include: {
      record: true,
      // OBS: använd EXAKT relationsnamnet från din schema-modell:
      // release_credit_role är join-relationen
      release_credit_role: { include: { role: true } },
    },
  },
} as const; */

// Business logic och data transformation
export const getAllPersons = async (): Promise<PersonDTO[]> => {
  const rows: Person[] = await personData.findAll();

  return rows.map(mapPersonBase); /*TODO:Centralisera toDTO */
};

// Mapper: raw -> DTO (utan includes)
function mapPersonBase(p: personData.PersonRaw): PersonDTO {
  return {
    id: p.id,
    first_name: p.first_name,
    alias: p.alias,
    last_name: p.last_name,
    ipi_number: p.ipi_number,
  };
}

// Mapper: credits -> records (utan roller)
function mapRecordsWithoutRoles(
  p: personData.PersonWithCreditsRaw
): RecordDTO[] {
  return p.release_credit.map((rc) => ({
    id: rc.record.id,
    title: rc.record.title,
    release_date: rc.record.release_date.toISOString(),
    created_at: rc.record.created_at.toISOString(),
    updated_at: rc.record.updated_at.toISOString(),
  }));
}

// Mapper: credits -> records (med roller)
function mapRecordsWithRoles(
  p: personData.PersonWithCreditsAndRolesRaw
): RecordDTO[] {
  return p.release_credit.map((rc) => ({
    id: rc.record.id,
    title: rc.record.title,
    release_date: rc.record.release_date.toISOString(),
    created_at: rc.record.created_at.toISOString(),
    updated_at: rc.record.updated_at.toISOString(),
    role: rc.release_credit_role.map((rr) => ({
      id: rr.role.id,
      role_title: rr.role.role_title,
      category: rr.role.category as
        | "Performance"
        | "Production"
        | "Songwriting",
    })),
  }));
}

// Huvudservice
export async function getPerson(
  id: number,
  opts: Options = {}
): Promise<PersonDTO> {
  if (opts.withRecordRoles && !opts.withRecords) {
    throw new Error("withRecordRoles requires withRecords");
  }

  const level: personData.PersonIncludeLevel = opts.withRecordRoles
    ? "withRecordsAndRoles"
    : opts.withRecords
    ? "withRecords"
    : "base";

  const raw = await personData.findById(id, level);
  if (!raw) throw new PersonNotFoundError(id);

  // Bas-DTO
  const personDTO: PersonDTO = mapPersonBase(raw as personData.PersonRaw);

  // Records (utan/med roller)
  if (level === "withRecords") {
    personDTO.records = mapRecordsWithoutRoles(
      raw as personData.PersonWithCreditsRaw
    );
  } else if (level === "withRecordsAndRoles") {
    personDTO.records = mapRecordsWithRoles(
      raw as personData.PersonWithCreditsAndRolesRaw
    );

    // All meta under samma flagga
    if (opts.withRecordRolesMeta) {
      // Person-meta
      personDTO.meta = buildPersonMeta(personDTO);

      // Record-meta (collaborators)
      const recordIds = (personDTO.records ?? []).map((r) => r.id);
      if (recordIds.length > 0) {
        const credits = await collabData.findCreditsForRecordIds(recordIds);
        // Grupp: recordId -> PersonDTO[]
        const byRecord = new Map<number, Map<number, PersonDTO>>();
        for (const c of credits) {
          if (c.person_id === personDTO.id) continue;
          const collaborator: PersonDTO = {
            id: c.person.id,
            first_name: c.person.first_name,
            alias: c.person.alias,
            last_name: c.person.last_name,
            ipi_number: c.person.ipi_number,
          };
          const bucket =
            byRecord.get(c.release_id) ?? new Map<number, PersonDTO>();
          bucket.set(collaborator.id, collaborator);
          byRecord.set(c.release_id, bucket);
        }
        const flat = new Map<number, PersonDTO[]>();
        for (const [rid, map] of byRecord)
          flat.set(rid, Array.from(map.values()));

        personDTO.records = augmentRecordsWithCollaborators(
          personDTO.records ?? [],
          flat
        );
      }
    }
  }

  return personDTO;
}
