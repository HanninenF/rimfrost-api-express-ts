// errorHandler.ts
import type { Request, Response, NextFunction } from "express";

export default function errorHandler(
  err: unknown,
  req: Request,
  res: Response,
  _next: NextFunction
): void {
  if (err instanceof Error) {
    console.error("Error:", err.message);
    res.status(500).json({
      err: "Internal Server Error",
      details: err.message,
    });
  } else {
    console.error("Unknown error:", err);
    res.status(500).json({
      err: "Internal Server Error",
      details: "Unknown error",
    });
  }
}
