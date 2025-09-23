import * as personData from "../data/persons.data.js";
import type { PersonDTO, PersonRow } from "../types/person.types.js";
const toDTO = (m: PersonRow): PersonDTO => {
  return {
    id: m.id,
    name: m.name,
    age: m.age,
    weapon: m.weapon,
    displayName: `${m.name} is ${m.age} years old${
      m.weapon ? ` and is wielding ${m.weapon} as main weapon` : ""
    }`,
  };
};

// Business logic och data transformation
export const getAllpersons = async (): Promise<PersonDTO[]> => {
  const rows: PersonRow[] = await personData.findAll();

  // Lägg till displayName för presentation
  return rows.map(toDTO);
};
