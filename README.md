# rimfrost-api-express-ts

A small, well-structured **Express + TypeScript** REST API for the **Rimfrost** domain using **Prisma ORM** and **MySQL**.
The project follows a **layer-first architecture** to clearly separate responsibilities:

- **db** – Prisma client / database connection
- **data** – DAO/Repository (raw DB access via Prisma)
- **services** – domain logic, DTO mapping, aggregation/meta
- **routes** – HTTP/API (validation, status codes, calls to services)
- **middleware** – e.g. `idParam`
- **config** – environment and app configuration

Domain focus: **person** — including related records, recordroles, and aggregated metadata via the `with` query parameter.

---

## 🧱 Tech Stack

- **Runtime:** Node.js, Express
- **Language:** TypeScript (ES2020, ESM)
- **ORM/DB:** Prisma + MySQL
- **Tooling:** nodemon, npm-run-all, dotenv, ESLint (flat config)

> ℹ️ ESLint (flat config) enforces explicit return types and a consistent code style.
> A project `.gitignore` keeps the repo clean (`dist/`, `node_modules/`, logs, `.env`). Both are included in the repo.

---

## 🗂️ Folder Structure

```
rimfrost-api-express-ts/
├─ src/
│  ├─ app.ts
│  ├─ config/
│  │  ├─ appConfig.ts
│  │  └─ env.ts
│  ├─ data/
│  │  ├─ collaborators.data.ts
│  │  ├─ persons.data.ts
│  │  ├─ records.data.ts
│  │  └─ songs.data.ts
│  ├─ db/
│  │  ├─ prismaClient.ts
│  │  └─ sql/
│  │     └─ migrations/
│  ├─ errors/
│  │  ├─ DomainError.ts
│  │  ├─ NotFoundErrors.ts
│  │  └─ RequestErrors.ts
│  ├─ middleware/
│  │  ├─ errorHandler.ts
│  │  └─ idParam.ts
│  ├─ routes/
│  │  ├─ common.ts
│  │  ├─ persons.routes.ts
│  │  ├─ records.routes.ts
│  │  └─ songs.routes.ts
│  ├─ services/
│  │  ├─ meta/
│  │  │  ├─ attachRecordCollaborators.ts
│  │  │  ├─ augmentRecordCollaborators.ts
│  │  │  ├─ buildPersonMeta.ts
│  │  │  └─ index.ts
│  │  ├─ persons.service.ts
│  │  ├─ records.service.ts
│  │  └─ songs.service.ts
│  ├─ types/
│  │  ├─ express.d.ts
│  │  ├─ person.types.ts
│  │  ├─ record.types.ts
│  │  ├─ role.types.ts
│  │  └─ song.types.ts
│  └─ utils/
│     ├─ asyncHandler.ts
│     ├─ calcMainRoles.ts
│     ├─ calcRoleCount.ts
│     ├─ calcYearsActive.ts
│     ├─ HttpError.ts
│     ├─ isNonEmptyString.ts
│     ├─ makeGetByForeignId.ts
│     └─ makeGetById.ts
└─ prisma/
   ├─ schema.prisma
   ├─ migrations/
   └─ (optional) seed.ts
```

> Even though `records.*` and `songs.*` exist in the project, the current API is focused on `persons`, with optional expansions using the `with` parameter.

---

## 🧪 API – Persons

### Base

- `GET /api/persons` — list all persons

### Detail with `with` parameter

- `GET /api/persons/:id` — fetch a single person (base data)
- `GET /api/persons/:id?with=records` — person including `records`
- `GET /api/persons/:id?with=records,recordroles` — person with `records` and `recordroles`
- `GET /api/persons/:id?with=records,recordroles,meta` — same as above, plus aggregated metadata (`recordCount`, `roleCount`, `years_active`, `mainRoles`, `mainRolesCount`)

> Examples:
>
> - `/api/persons/18?with=records`
> - `/api/persons/18?with=records,recordroles`
> - `/api/persons/18?with=records,recordroles,meta`

---

## ❓ Why layer-first?

It isolates responsibilities (data → service → routes), makes testing easier, and lets you evolve DTOs/validation without leaking database details into the HTTP layer.

---

## ✅ Prerequisites

- Node.js ≥ 18 LTS
- MySQL 8 (or compatible server)

  - Make sure the MySQL `bin` folder is added to your system `PATH`

    - **Windows:** `C:\Program Files\MySQL\MySQL Server 8.0\bin`
    - **macOS/Linux (Homebrew):** `/usr/local/mysql/bin`

- Prisma CLI (installed via dev dependencies)

---

## 🔧 Setup

### 1) Install

```bash
npm install
```

### 2) Environment Variables

```bash
# Windows PowerShell
Copy-Item .env.example .env

# macOS/Linux
cp .env.example .env
```

Then fill in your values in `.env`.

---

### 3) Database

You have two options for initializing the database:

#### Option A – Full setup (reset + migrate + seed)

```bash
npm run db:setup
```

This will reset the schema, apply all migrations, and run the seed script.
⚠️ **Warning:** This clears all existing data in the database.

#### Option B – Step by step

```bash
npm run prisma:generate   # Generate Prisma client
npm run prisma:migrate    # Apply migrations
npm run prisma:studio     # (optional) Open Prisma Studio
```

---

### 4) Run in development

```bash
npm run dev
```

Runs TypeScript watch and nodemon in parallel.
The server starts at [http://localhost:3000](http://localhost:3000) (unless `PORT` is set).

---

## 🧰 Notes on Tooling

- **ESLint (flat config):** Keeps the code style consistent and enforces explicit return types (type-aware linting for TS).
- **.gitignore:** Keeps the repo clean (`dist/`, `node_modules/`, logs, `.env`), while committing `.env.example` for onboarding.

---

## 📝 License

MIT
