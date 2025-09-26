// src/types/monsters.types.ts
import type { RowDataPacket } from "mysql2";

import type { RecordDTO } from "./record.types.js";
/** Rådata från databasen (SELECT) */
export type PersonRow = RowDataPacket & {
  id: number;
  first_name: string;
  alias: string | null;
  last_name: string;
  ipi_number: string | null;
  created_at: string;
  updated_at: string;
};

/** Payload vid skapande (POST) */
export type NewPerson = {
  first_name: string;
  alias?: string | null;
  last_name: string;
  ipi_number?: string | null;
};

/** Payload vid uppdatering (PATCH) */
export type UpdatePerson = Partial<NewPerson>;

/** Det vi skickar ut från API:t (service lägger till ...) */
export type PersonDTO = {
  id: number;
  first_name: string;
  alias: string | null;
  last_name: string;
  ipi_number: string | null;
  created_at: string;
  updated_at: string;
  records?: RecordDTO[];
  roles?: string[];
};

/* Prisma types */
import type { Prisma } from "../generated/prisma/index.js";

export type Person = Prisma.personGetPayload<true>;

export type PersonWithCredits = Prisma.personGetPayload<{
  include: {
    release_credit: {
      include: {
        record: true; // eller select: { id: true, title: true, release_date: true }
      };
    };
  };
}>;

export type ReleaseCreditWithRecord =
  PersonWithCredits["release_credit"][number];
