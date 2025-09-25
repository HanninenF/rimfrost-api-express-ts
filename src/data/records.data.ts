import prisma from "../db/prismaClient.js";
import type { Record } from "../types/record.types.js";

// Pure data access - prisma
export const findAll = async (): Promise<Record[]> => {
  return await prisma.record.findMany();
};

export const findById = async (id: number): Promise<Record | null> => {
  return await prisma.record.findUnique({
    where: { id },
  });
};
