import type { ErrorRequestHandler } from "express";
import { HttpError } from "../utils/HttpError.js";

const errorHandler: ErrorRequestHandler = (err, req, res, _next) => {
  const route = `${req.method} ${req.originalUrl}`;

  if (err instanceof HttpError) {
    // Logga detaljerat på servern (men skicka aldrig details till klienten)
    console.error(
      `[${route}] ${err.code ?? ""}`.trim(),
      "-",
      err.stack ?? err.message
    );

    return res.status(err.status).json({
      err: err.status >= 500 ? "Internal Server Error" : "Request Error",
      code: err.code, // ofarligt om du själv kontrollerar dina koder (t.ex. PERSON_NOT_FOUND)
      route, // ofarligt: bara metod + path
      status: err.status,
    });
  }

  // Okänt/tredjepartsfel → 500
  console.error(
    `[${route}] -`,
    err instanceof Error ? err.stack ?? err.message : err
  );

  return res.status(500).json({
    err: "Internal Server Error",
    route,
    status: 500,
  });
};

export default errorHandler;
