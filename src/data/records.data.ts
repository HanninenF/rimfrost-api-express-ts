/* import prisma from "../db/prismaClient.js";
import type { RecordModel as RecordModel } from "../types/record.types.js";

// Pure data access - prisma
export const findAll = async (): Promise<RecordModel[]> => {
  return await prisma.record.findMany();
};

export const findById = async (id: number): Promise<RecordModel | null> => {
  return await prisma.record.findUnique({
    where: { id },
  });
};

// Hämta alla skivor för en viss person
export const findByPersonId = async (
  person_id: number
): Promise<RecordModel[]> => {
  return prisma.record.findMany({
    where: {
      release_credit: {
        some: { person_id },
      },
    },
    orderBy: { id: "asc" },
  });
};
 */
