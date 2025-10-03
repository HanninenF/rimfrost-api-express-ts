// errors/RequestErrors.ts
import { HttpError } from "../utils/HttpError.js";

export class InvalidWithError extends HttpError {
  constructor(details: string) {
    // 400 + "Request Error" + code + (med details)
    super(400, "Request Error", "INVALID_WITH", details);
    this.name = "InvalidWithError";
  }
}

export class InvalidIdError extends HttpError {
  constructor() {
    // 400 + "Request Error" + code + (utan details!)
    super(400, "Request Error", "INVALID_ID");
    this.name = "InvalidIdError";
  }
}
