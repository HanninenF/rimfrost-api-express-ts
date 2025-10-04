/* // utils/makeGetByForeignId.ts
import type { AsyncRequestHandler } from "./asyncHandler.js";
import { HttpError } from "./HttpError.js";

// Valfri felklass för "ägaren" (t.ex. PersonNotFoundError)
type ErrorConstructor<E extends Error> = abstract new (
  id: number,
  ...rest: unknown[]
) => E;
 */
/**
 * Bygger en handler för "GET /:id/<resource>" som returnerar en lista (T[]).
 * Ex: /api/persons/:id/records → alla records för personen.
 *
 * - Validerar och parsar id (locals → params).
 * - Returnerar alltid array (även tom).
 * - Översätter ev. domänfel till 404 om NotFoundError anges.
 
export default function makeGetByForeignId<T, E extends Error>(
  getByForeignId: (id: number) => Promise<T[]>,
  options?: {
    NotFoundError?: ErrorConstructor<E>; // t.ex. PersonNotFoundError
    notFoundCode?: string; // t.ex. "PERSON_NOT_FOUND"
    ownerName?: string; // t.ex. "Person"
  }
): AsyncRequestHandler {
  const NotFoundError = options?.NotFoundError;
  const notFoundCode = options?.notFoundCode ?? "NOT_FOUND";
  const ownerName = options?.ownerName ?? "Resource";

  return async (req, res) => {
    // Robust id-parsning (samma stil som makeGetById)
    const rawId =
      typeof res.locals.id === "number"
        ? String(res.locals.id)
        : req.params.id ?? "";

    const id = Number.parseInt(rawId.trim(), 10);
    if (!Number.isFinite(id)) {
      throw new HttpError(400, "Invalid id", "INVALID_ID");
    }

    try {
      const data = await getByForeignId(id);
      // Designval: lista kan vara tom → fortfarande 200
      res.json(data);
    } catch (err) {
      if (NotFoundError && err instanceof NotFoundError) {
        // Ägaren (t.ex. Person) hittades inte
        throw new HttpError(
          404,
          `${ownerName} with id ${id} not found`,
          notFoundCode
        );
      }
      throw err;
    }
  };
}
*/
