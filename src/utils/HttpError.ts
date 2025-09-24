//error class HTTP-specifikt fel (endast i transportlagret)
export class HttpError extends Error {
  constructor(
    public status: number,
    message: string,
    public code?: string,
    public route?: string
  ) {
    super(message);
    this.name = "HttpError";
  }
}
