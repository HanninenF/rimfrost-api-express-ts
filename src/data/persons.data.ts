// src/data/persons.data.ts
import prisma from "../db/prismaClient.js";
import type { Prisma } from "@prisma/client";

// Rå Prisma-typer (din egen domän-typ funkar också)
export type PersonRaw = Prisma.personGetPayload<true>;
export type PersonWithCreditsRaw = Prisma.personGetPayload<{
  include: { release_credit: { include: { record: true } } };
}>;
export type PersonWithCreditsAndRolesRaw = Prisma.personGetPayload<{
  include: {
    release_credit: {
      include: {
        record: true;
        release_credit_role: { include: { role: true } };
      };
    };
  };
}>;

export async function findAll(): Promise<PersonRaw[]> {
  return prisma.person.findMany();
}

// En tydlig “selector” för vad vi ska includa
export type PersonIncludeLevel = "base" | "withRecords" | "withRecordsAndRoles";

export async function findById(
  id: number,
  level: PersonIncludeLevel
): Promise<
  PersonRaw | PersonWithCreditsRaw | PersonWithCreditsAndRolesRaw | null
> {
  const args: Prisma.personFindUniqueArgs = { where: { id } };

  if (level === "withRecords") {
    args.include = { release_credit: { include: { record: true } } } as const;
  } else if (level === "withRecordsAndRoles") {
    args.include = {
      release_credit: {
        include: {
          record: true,
          release_credit_role: { include: { role: true } },
        },
      },
    } as const;
  }

  return prisma.person.findUnique(args);
}
