import * as personData from "../data/persons.data.js";
import type { PersonDTO, PersonRow } from "../types/person.types.js";
const toDTO = (p: PersonRow): PersonDTO => {
  return {
    id: p.id,
    first_name: p.first_name,
    alias: p.alias ? p.alias : null,
    last_name: p.last_name,
    ipi_number: p.ipi_number ? p.ipi_number : null,
    created_at: p.created_at,
    updated_at: p.updated_at,
  };
};

// Business logic och data transformation
export const getAllPersons = async (): Promise<PersonDTO[]> => {
  const rows: PersonRow[] = await personData.findAll();

  return rows.map(toDTO);
};

export const getPersonById = async (id: string): Promise<PersonDTO | null> => {
  const row: PersonRow | null = await personData.findById(id);

  if (!row) {
    return null;
  }
  return toDTO(row);
};
