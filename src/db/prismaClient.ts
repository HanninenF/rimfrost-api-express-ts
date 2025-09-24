// PRISMA CLIENT: Denna fil ersätter den gamla mysql2-lösningen.
// Använd alltid detta prisma-objekt för databasaccess i projektet.
// Se till att schema.prisma är uppdaterad och kör `prisma generate` vid behov.

import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
export default prisma;
