/* // DEPRECATED: Denna fil ersätts av Prisma (se prismaClient.ts).
// Behålls tills vidare som referens till gamla mysql2-lösningen.


import mysql from "mysql2/promise";
import type { Connection } from "mysql2/promise";
import { env } from "../config/env.js";

let connection: Connection;

export const getConnection = async (): Promise<Connection> => {
  if (!connection) {
    connection = await mysql.createConnection({
      host: env.DB_HOST,
      port: env.DB_PORT,
      user: env.DB_USER,
      password: env.DB_PASSWORD,
      database: env.DB_NAME,
    });
  }
  return connection;
};
 */
