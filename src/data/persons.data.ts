/* import { getConnection } from "../db/index.deprecated.js";
import type { PersonRow } from "../types/person.types.js"; */

import prisma from "../db/prismaClient.js";
import type { Person } from "../types/person.types.js";

// Pure data access - bara SQL queries
export const findAll = async (): Promise<Person[]> => {
  return await prisma.person.findMany();
  /*   const db = await getConnection();
  const [rows] = await db.execute<PersonRow[]>("SELECT * FROM person");
  return rows; */
};

export const findById = async (id: number): Promise<Person | null> => {
  return await prisma.person.findUnique({
    where: { id },
  });

  /*  const db = await getConnection();
  const [rows] = await db.execute<PersonRow[]>(
    "SELECT * FROM person WHERE id=?",
    [id]
  );
  return rows[0] ?? null; */
};
