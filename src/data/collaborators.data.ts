// src/data/collaborators.data.ts
import type { Prisma } from "../generated/prisma/index.js";
import prisma from "../db/prismaClient.js";

type ReleaseCreditWithRolesAndPerson = Prisma.release_creditGetPayload<{
  include: {
    person: true;
    release_credit_role: { include: { role: true } };
    // om du behöver recordId i metan, ta med relationen till record också:
    record: { select: { id: true } };
  };
}>;

export async function findCreditsForRecordIds(
  record_ids: number | number[]
): Promise<ReleaseCreditWithRolesAndPerson[]> {
  return prisma.release_credit.findMany({
    where: {
      record: {
        id: { in: Array.isArray(record_ids) ? record_ids : [record_ids] },
      },
    },
    include: {
      person: true,
      release_credit_role: { include: { role: true } },
      record: { select: { id: true } },
    },
  });
}
