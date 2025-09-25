import type { Request, Response, NextFunction } from "express";
import { HttpError } from "../utils/HttpError.js";

//Validera och parsa :id en gång
export default function idParam(
  req: Request,
  res: Response,
  next: NextFunction,
  rawId: string
): void {
  const id = Number.parseInt(rawId, 10);

  if (!Number.isFinite(id)) {
    throw new HttpError(400, "Invalid id", "INVALID_ID");
  }
  res.locals.id = id;
  next();
}
