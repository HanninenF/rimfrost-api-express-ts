// persons.service.ts
import prisma from "../db/prismaClient.js";
import { PersonNotFoundError } from "../errors/NotFoundErrors.js";
import {
  includeCredits,
  includeCreditsAndRoles,
  type Person,
  type PersonDTO,
  type PersonWithCredits,
  type PersonWithCreditsAndRoles,
} from "../types/person.types.js";
import * as personData from "../data/persons.data.js";
import { toDTO } from "./persons.service.Deprecated.js";

type Options = {
  withRecords?: boolean;
  withRecordRoles?: boolean;
};

// Business logic och data transformation
export const getAllPersons = async (): Promise<PersonDTO[]> => {
  const rows: Person[] = await personData.findAll();

  return rows.map(toDTO);
};

export async function getPerson(
  id: number,
  opts: Options = {}
): Promise<PersonDTO> {
  if (opts.withRecordRoles && !opts.withRecords) {
    // valfritt men tydligt fel om någon begär roller utan records
    throw new Error("withRecordRoles requires withRecords");
  }

  const include = opts.withRecordRoles
    ? includeCreditsAndRoles
    : opts.withRecords
    ? includeCredits
    : undefined;

  const person = await prisma.person.findUnique({ where: { id }, include });
  if (!person) throw new PersonNotFoundError(id);

  const dto: PersonDTO = {
    id: person.id,
    first_name: person.first_name,
    alias: person.alias,
    last_name: person.last_name,
    ipi_number: person.ipi_number,
    created_at: person.created_at.toISOString(),
    updated_at: person.updated_at.toISOString(),
  };

  if (opts.withRecords) {
    if (opts.withRecordRoles) {
      const p = person as PersonWithCreditsAndRoles;
      dto.records = p.release_credit.map((rc) => ({
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
          created_at: rr.role.created_at.toISOString(),
          updated_at: rr.role.updated_at.toISOString(),
        })),
      }));
    } else {
      const p = person as PersonWithCredits;
      dto.records = p.release_credit.map((rc) => ({
        id: rc.record.id,
        title: rc.record.title,
        release_date: rc.record.release_date.toISOString(),
        created_at: rc.record.created_at.toISOString(),
        updated_at: rc.record.updated_at.toISOString(),
      }));
    }
  }

  return dto;
}
