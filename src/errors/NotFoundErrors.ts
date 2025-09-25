import { DomainError } from "./DomainError.js";

export class PersonNotFoundError extends DomainError {
  constructor(public id: number) {
    super(`Person with id ${id} not found`);
  }
}

export class RecordNotFoundError extends DomainError {
  constructor(public id: number) {
    super(`Record with id ${id} not found`);
  }
}

export class SongNotFoundError extends DomainError {
  constructor(public id: number) {
    super(`Song with id ${id} not found`);
  }
}
