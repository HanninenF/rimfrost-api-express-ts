// persons.service.ts
import prisma from "../db/prismaClient.js";
import { PersonNotFoundError } from "../errors/NotFoundErrors.js";
import type {
  Person,
  PersonDTO,
  PersonWithCredits,
  ReleaseCreditWithRecord,
} from "../types/person.types.js";
import * as personData from "../data/persons.data.js";
import { toDTO } from "./persons.service.Deprecated.js";

type Options = {
  withRecords?: boolean;
  withRoles?: boolean;
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
  const needCredits = !!(opts.withRecords || opts.withRoles);

  const person = await prisma.person.findUnique({
    where: { id },
    include: needCredits
      ? {
          // gå via join-tabellen
          release_credit: {
            include: {
              // inkludera record bara om records efterfrågas
              record: !!opts.withRecords,
            },
          },
        }
      : undefined,
  });

  if (!person) throw new PersonNotFoundError(id);

  // Bas-DTO
  const dto: PersonDTO = {
    id: person.id,
    first_name: person.first_name,
    alias: person.alias,
    last_name: person.last_name,
    ipi_number: person.ipi_number,
    created_at:
      person.created_at instanceof Date
        ? person.created_at.toISOString()
        : (person.created_at as unknown as string),
    updated_at:
      person.updated_at instanceof Date
        ? person.updated_at.toISOString()
        : (person.updated_at as unknown as string),
  };

  if (opts.withRecords) {
    const credits =
      person.release_credit as PersonWithCredits["release_credit"];
    dto.records = credits.map((rc: ReleaseCreditWithRecord) => ({
      id: rc.record.id,
      title: rc.record.title,
      release_date: rc.record.release_date.toISOString(),
      created_at: rc.record.created_at.toISOString(),
      updated_at: rc.record.updated_at.toISOString(),
    }));
  }

  return dto as PersonDTO;
}
