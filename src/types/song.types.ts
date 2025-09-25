export type SongDTO = {
  id: number;
  title: string;
  duration: number;
  isrc?: string | null;
  created_at: string;
  updated_at: string;
};

/* Prisma types */
import type { Prisma } from "../generated/prisma/index.js";

export type Song = Prisma.songGetPayload<true>;
