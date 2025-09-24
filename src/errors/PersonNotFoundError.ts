import { DomainError } from "./DomainError.js";

export class PersonNotFoundError extends DomainError {
  constructor(public id: number) {
    super(`Person with id ${id} not found`);
  }
}
