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
};

/* Prisma types */
import type { Prisma } from "../generated/prisma/index.js";

export type PersonWithCredits = Prisma.personGetPayload<{
  include: { release_credit: { include: { record: true } } };
}>;

export type PersonWithCreditsAndRoles = Prisma.personGetPayload<{
  include: {
    release_credit: {
      include: {
        record: true;
        release_credit_role: { include: { role: true } };
      };
    };
  };
}>;

// types/person.types.ts
export type Person = Prisma.personGetPayload<true>;
