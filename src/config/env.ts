import * as dotenv from "dotenv";
dotenv.config();

//plocka ut miljövariabler från process.env och samla i ett objekt för smidigare åtkomst i appen
export const env = {
  NODE_ENV: process.env.NODE_ENV ?? "development",
  PORT: Number(process.env.PORT ?? 3000),

  DB_HOST: process.env.DB_HOST!,
  DB_PORT: Number(process.env.DB_PORT!),
  DB_USER: process.env.DB_USER!,
  DB_PASSWORD: process.env.DB_PASS!,
  DB_NAME: process.env.DB_NAME!,
};
