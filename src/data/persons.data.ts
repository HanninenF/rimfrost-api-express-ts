import prisma from "../db/prismaClient.js";
import type { Person } from "../types/person.types.js";

// Pure data access - bara SQL queries
export const findAll = async (): Promise<Person[]> => {
  return await prisma.person.findMany();
};

export const findById = async (id: number): Promise<Person | null> => {
  return await prisma.person.findUnique({
    where: { id },
  });
};
