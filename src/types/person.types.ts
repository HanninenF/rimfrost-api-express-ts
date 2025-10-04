/* import type { RowDataPacket } from "mysql2";*/

import type { RecordDTO } from "./record.types.js";
/* Rådata från databasen (SELECT) 
export type PersonRow = RowDataPacket & {
  id: number;
  first_name: string;
  alias: string | null;
  last_name: string;
  ipi_number: string | null;
  created_at: string;
  updated_at: string;
}; */

/** Payload vid skapande (POST) */
export type NewPerson = {
  first_name: string;
  alias?: string | null;
  last_name: string;
  ipi_number?: string | null;
};

/** Payload vid uppdatering (PATCH) */
export type UpdatePerson = Partial<NewPerson>;

export type PersonMetaDTO = {
  years_active: number;
  recordCount: number;
  roleCount: number;
  mainRoles?: RoleDTO[] | null;
  mainRolesCount?: number | null;
};

/** Det vi skickar ut från API:t (service lägger till ...) */
export type PersonDTO = {
  id: number;
  first_name: string;
  alias: string | null;
  last_name: string;
  ipi_number: string | null;

  records?: RecordDTO[];
  meta?: PersonMetaDTO;
};

/* Prisma types */
import type { Prisma } from "../generated/prisma/index.js";
import type { RoleDTO } from "./role.types.js";

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
