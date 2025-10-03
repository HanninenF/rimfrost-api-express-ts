export class HttpError extends Error {
  constructor(
    public status: number,
    public code: string,
    public messageForClient: string = "Request Error",
    public details?: string
  ) {
    super(`${code}: ${messageForClient}${details ? ` - ${details}` : ""}`);
    this.name = "HttpError";
  }
}
