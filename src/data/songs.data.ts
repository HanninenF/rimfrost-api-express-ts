import prisma from "../db/prismaClient.js";
import type { Song } from "../types/song.types.js";

// Pure data access - bara SQL queries
export const findAll = async (): Promise<Song[]> => {
  return await prisma.song.findMany();
};

export const findById = async (id: number): Promise<Song | null> => {
  return await prisma.song.findUnique({
    where: { id },
  });
};
