import * as personData from "../data/persons.data.js";
import { PersonNotFoundError } from "../errors/NotFoundErrors.js";
import type { PersonDTO, Person } from "../types/person.types.js";

export const toDTO = (p: Person): PersonDTO => {
  return {
    id: p.id,
    first_name: p.first_name,
    alias: p.alias ? p.alias : null,
    last_name: p.last_name,
    ipi_number: p.ipi_number ? p.ipi_number : null,
    created_at:
      p.created_at instanceof Date
        ? p.created_at.toISOString()
        : (p.created_at as unknown as string),
    updated_at:
      p.updated_at instanceof Date
        ? p.updated_at.toISOString()
        : (p.updated_at as unknown as string),
  };
};

// Business logic och data transformation
export const getAllPersons = async (): Promise<PersonDTO[]> => {
  const rows: Person[] = await personData.findAll();

  return rows.map(toDTO);
};

export const getPersonById = async (id: number): Promise<PersonDTO | null> => {
  const row: Person | null = await personData.findById(id);

  if (!row) {
    throw new PersonNotFoundError(id);
  }
  return toDTO(row);
};

//servera person och alla kopplade skivor
export const getPersonWithRecords = async (id: number): Promise<PersonDTO> => {
  const row = await personData.findByIdWithRecords(id);
  if (!row) throw new PersonNotFoundError(id);
  return toDTO(row);
};
