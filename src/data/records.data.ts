import prisma from "../db/prismaClient.js";
import type { Record } from "../types/record.types.js";

// Pure data access - prisma
export const findAll = async (): Promise<Record[]> => {
  return await prisma.record.findMany();
};
