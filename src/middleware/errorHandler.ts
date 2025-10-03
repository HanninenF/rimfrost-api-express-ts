// middlewares/errorHandler.ts
import type { ErrorRequestHandler } from "express";
import { HttpError } from "../utils/HttpError.js";

// Vilka koder får INTE skicka details till klienten:
const HIDE_DETAILS_FOR = new Set(["INVALID_ID"]);

const errorHandler: ErrorRequestHandler = (err, req, res, _next) => {
  const route = `${req.method} ${req.originalUrl}`;

  // Logga allt internt (stack/meddelande), men skicka aldrig stack till klient
  console.error(
    `[${route}]`,
    err instanceof Error ? err.stack ?? err.message : err
  );

  if (err instanceof HttpError) {
    const body: Record<string, unknown> = {
      err: err.messageForClient, // alltid "Request Error" för 4xx
      code: err.code, // t.ex. INVALID_ID | INVALID_WITH
      status: err.status, // 400, 404 etc.
      route, // "GET /api/.."
    };

    // Lägg bara till details om koden inte är i “no-details”-listan och details finns
    if (!HIDE_DETAILS_FOR.has(err.code) && err.details) {
      body.details = err.details;
    }

    return res.status(err.status).json(body);
  }

  // Fallback för oväntade fel
  return res.status(500).json({
    err: "Internal Server Error",
    code: "UNHANDLED_ERROR",
    status: 500,
    route,
  });
};
export default errorHandler;
