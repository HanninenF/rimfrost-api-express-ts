import type { Request, Response, NextFunction } from "express";
import { HttpError } from "../utils/HttpError.js";

//Validera och parsa :id en gång
console.log("[idParam LOADED]");
export default function idParam(
  req: Request,
  res: Response,
  next: NextFunction,
  rawId: string,
  _name?: string
): void {
  const id = Number.parseInt(rawId, 10);
  // Logga för felsökning
  console.log("[idParam] rawId=", rawId, "→", id);

  if (!Number.isFinite(id)) {
    throw new HttpError(400, "Invalid id", "INVALID_ID");
  }
  res.locals.id = id;
  next();
}
