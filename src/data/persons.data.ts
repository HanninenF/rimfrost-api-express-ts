import { getConnection } from "../db/index.js";
import type { PersonRow } from "../types/person.types.js";

// Pure data access - bara SQL queries
export const findAll = async (): Promise<PersonRow[]> => {
  const db = await getConnection();
  const [rows] = await db.execute<PersonRow[]>("SELECT * FROM person");
  return rows;
};

export const findById = async (id: string): Promise<PersonRow | null> => {
  const db = await getConnection();
  const [rows] = await db.execute<PersonRow[]>(
    "SELECT * FROM person WHERE id=?",
    [id]
  );
  return rows[0] ?? null;
};
