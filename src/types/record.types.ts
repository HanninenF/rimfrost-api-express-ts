/** Payload vid skapande (POST) */
export type NewRecord = {
  title: string;
  release_date: string;
};

/** Payload vid uppdatering (PATCH) */
export type UpdateRecord = Partial<NewRecord>;

/** Det vi skickar ut från API:t (service lägger till ...) */
export type RecordDTO = {
  id: number;
  title: string;
  release_date: string;
  created_at: string;
  updated_at: string;
};

/* Prisma types */

import type { Prisma } from "../generated/prisma/index.js";

export type Record = Prisma.recordGetPayload<true>;
