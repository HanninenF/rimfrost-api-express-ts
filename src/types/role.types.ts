import type { Prisma } from "../generated/prisma/index.js";

export type RoleCategory = "Performance" | "Production" | "Songwriting";

export type RoleDTO = {
  id: number;
  role_title: string;
  category: RoleCategory;
};

export type Role = Prisma.roleGetPayload<true>;
