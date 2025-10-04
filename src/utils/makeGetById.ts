/* import { HttpError } from "./HttpError.js";
import type { AsyncRequestHandler } from "./asyncHandler.js";

// Konstruktortyp: tar id:number (ev. fler argument senare)
type ErrorConstructor<E extends Error> = abstract new (
  id: number,
  ...rest: unknown[]
) => E;

export default function makeGetById<T, E extends Error>(
  getById: (id: number) => Promise<T>,
  NotFoundError: ErrorConstructor<E>,
  notFoundCode: string,
  resourceName: string
): AsyncRequestHandler {
  return async (req, res) => {
    const rawId =
      typeof res.locals.id === "number"
        ? String(res.locals.id)
        : req.params.id ?? "";

    const id = Number.parseInt(rawId.trim(), 10);
    if (!Number.isFinite(id)) {
      throw new HttpError(400, "Invalid id", "INVALID_ID");
    }

    try {
      const data = await getById(id);

      // Om din service KAN returnera null istället för att kasta:
      if (data == null) {
        throw new HttpError(
          404,
          `${resourceName} with id ${id} not found`,
          notFoundCode
        );
      }

      res.json(data);
    } catch (err) {
      if (err instanceof NotFoundError) {
        throw new HttpError(
          404,
          `${resourceName} with id ${id} not found`,
          notFoundCode
        );
      }
      throw err;
    }
  };
}
 */
