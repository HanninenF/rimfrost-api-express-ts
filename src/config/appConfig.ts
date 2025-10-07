// src/config/appConfig.ts
import { env } from "./env.js";

export const appConfig = {
  port: env.PORT,
  //flaggan baseras på NODE_ENV; sätts via scripts i package.json
  isDev: env.NODE_ENV !== "production",
  isProd: env.NODE_ENV === "production",
  //lägg authorization här
  //vilka adresser som får anropa API:t från webbläsare
  //Tillåtna metoder GET, POST mm
};
