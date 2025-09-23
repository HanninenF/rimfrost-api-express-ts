// src/config/appConfig.ts
import { env } from "./env.js";

export const appConfig = {
  port: env.PORT,
  isDev: env.NODE_ENV !== "production",
};
