// En enkel bas för domänfel (ingen HTTP-kunskap här)
export class DomainError extends Error {
  constructor(message: string) {
    super(message);
    this.name = new.target.name;
  }
}
