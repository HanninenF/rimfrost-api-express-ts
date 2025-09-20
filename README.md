# rimfrost-api-express-ts

A small, well-structured **Express + TypeScript** REST API for the **Rimfrost** domain using **Prisma ORM** and **MySQL**.  
The project follows a **layer-first architecture** for clear separation of concerns:

- **db** (Prisma client / connection)
- **data** (DAO/Repository – raw DB access)
- **services** (domain logic, DTOs, mapping)
- **routes** (HTTP/API – validation, status codes)
- **middleware** (404/error)
- **config** (env/app settings)

Domain entities: **person**, **record**, **song**, **format**, **role**.

---

## 🚀 Features

- TypeScript with ESM (NodeNext)
- Prisma ORM (MySQL)
- Environment-based configuration via dotenv (`.env` / `.env.example`)
- Fast dev loop (TypeScript watch + nodemon)
- Centralized error handling and 404 middleware
- Clean separation of data/service/route layers (layer-first)

---

## 🧱 Tech Stack

- **Runtime:** Node.js, Express
- **Language:** TypeScript (ES2020, ESM)
- **ORM/DB:** Prisma + MySQL
- **Tooling:** nodemon, npm-run-all, dotenv, ESLint (flat config)

> ℹ️ ESLint (flat config) enforces explicit returns and consistent style, and a project `.gitignore` keeps the repo clean (`dist/`, `node_modules/`, logs, `.env`). Both are included in the repo.

---

## 🗂️ Folder Structure

```

rimfrost-api-express-ts/
├─ src/
│  ├─ app.ts
│  ├─ config/
│  │  ├─ env.ts
│  │  └─ appConfig.ts
│  ├─ db/
│  │  └─ prismaClient.ts
│  ├─ data/                  # DAO/Repository – only DB calls (Prisma)
│  │  ├─ persons.data.ts
│  │  ├─ records.data.ts
│  │  ├─ songs.data.ts
│  │  ├─ formats.data.ts
│  │  └─ roles.data.ts
│  ├─ services/              # Domain logic + DTO mapping
│  │  ├─ persons.service.ts
│  │  ├─ records.service.ts
│  │  ├─ songs.service.ts
│  │  ├─ formats.service.ts
│  │  └─ roles.service.ts
│  ├─ routes/                # HTTP/API – validate, call service, return JSON
│  │  ├─ persons.routes.ts
│  │  ├─ records.routes.ts
│  │  ├─ songs.routes.ts
│  │  ├─ formats.routes.ts
│  │  ├─ roles.routes.ts
│  │  └─ meta.routes.ts      # cross-entity metadata/aggregations
│  ├─ middleware/
│  │  ├─ errorHandler.ts
│  │  └─ notFound.ts
│  ├─ types/
│  │  ├─ person.types.ts
│  │  ├─ record.types.ts
│  │  ├─ song.types.ts
│  │  ├─ format.types.ts
│  │  └─ role.types.ts
│  └─ public/
│     └─ index.html
└─ prisma/
├─ schema.prisma
├─ migrations/
└─ seed.ts  (optional)

```

**Why layer-first?**  
It isolates responsibilities (data → service → routes), makes testing easier, and lets you evolve DTOs/validation without leaking DB details into the HTTP layer.

---

## ✅ Prerequisites

- Node.js ≥ 18 LTS
- MySQL 8 (or compatible server)
- Prisma CLI (installed via dev deps)

---

## 🔧 Setup

### 1) Install

```bash
npm install
```

### 2) Environment Variables

Copy the template and fill your values:

```bash
# Windows PowerShell
Copy-Item .env.example .env
# macOS/Linux
cp .env.example .env
```

`.env.example`:

```env
# App
PORT=3000
NODE_ENV=development

# Prisma / MySQL
# Format: mysql://USER:PASSWORD@HOST:PORT/DATABASE
DATABASE_URL=mysql://root:password@localhost:3306/rimfrostdb
```

### 3) Database (Prisma)

```bash
npm run prisma:generate
npm run prisma:migrate
# optional
npm run prisma:studio
```

### 4) Run in development

```bash
npm run dev
```

This runs TypeScript watch and nodemon in parallel.
Server starts at `http://localhost:3000` (unless `PORT` is set).

---

## 🧪 API (examples)

> Replace with your final routes. These examples align with the entities and course requirements (all data, subsets, and cross-entity metadata).

### Persons

- `GET /api/persons` — list all persons
- `GET /api/persons/:id` — get one person
- `GET /api/persons?role=vocal` — filter by role (subset)
- `POST /api/persons` — create
- `PATCH /api/persons/:id` — update
- `DELETE /api/persons/:id` — delete

### Records

- `GET /api/records` — list records (optionally include format)
- `GET /api/records/:id` — record details (+ songs)
- `GET /api/records?format=vinyl` — subset by format

### Songs

- `GET /api/songs` — list songs
- `GET /api/songs/:id` — song details

### Formats / Roles

- `GET /api/formats` — list formats
- `GET /api/roles` — list roles

### Metadata (cross-entity)

- `GET /api/meta/stats` — aggregated stats across entities (e.g., counts, groupBy format, avg songs/record, first/latest release)

---

## ⚙️ Configuration

- `src/config/env.ts` loads `.env` and exposes parsed values (e.g., `PORT` as a number).
- `src/config/appConfig.ts` derives runtime flags (e.g., `isDev`, CORS allowlist).

---

## 🛡️ Error Handling & 404

- `src/middleware/notFound.ts` — returns 404 for unknown routes
- `src/middleware/errorHandler.ts` — consistent JSON error shape, maps domain errors to HTTP

**Example error shape**

```json
{ "error": "BadRequest", "message": "Invalid query parameter 'format'" }
```

---

## 🧹 Graceful Shutdown

On `SIGINT`/`SIGTERM`:

1. Stop accepting new HTTP requests
2. `await prisma.$disconnect()`
3. Exit with code `0`

---

## 🧰 Notes on Tooling

- **ESLint (flat config):** Included to keep style consistent and enforce explicit function return types (type-aware lint for TS).
- **.gitignore:** Included to keep the repo clean (`dist/`, `node_modules/`, logs, `.env`), while committing `.env.example` for onboarding.

---

## 📝 License

MIT

```

Vill du att jag också uppdaterar API-exemplen med några av dina relationer (t.ex. `/records/:id/tracklist`, `/songs/:songId/writers`, `/records/:id/editions`)? Jag kan lägga in dem direkt under API-sektionen.
```
