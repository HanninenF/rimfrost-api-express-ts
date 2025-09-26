/** Payload vid skapande (POST) */
export type NewRecord = {
  title: string;
  release_date: string;
};

/** Payload vid uppdatering (PATCH) */
export type UpdateRecord = Partial<NewRecord>;

export type RoleCategory = "Performance" | "Production" | "Songwriting";

export type RoleDTO = {
  id: number;
  role_title: string;
  category: RoleCategory;
  created_at: string;
  updated_at: string;
};

/** Det vi skickar ut från API:t (service lägger till ...) */
export type RecordDTO = {
  id: number;
  title: string;
  release_date: string;
  created_at: string;
  updated_at: string;
  role?: RoleDTO[];
};

/* Prisma types */

// typer – type-only import är ok
import type { Prisma } from "../generated/prisma/index.js";

export type RecordModel = Prisma.recordGetPayload<true>;
