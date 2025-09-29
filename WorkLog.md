# Work Log

## 2025-09-20

| Type | Item                                                      |
| ---- | --------------------------------------------------------- |
| Done | Scaffolded layer-first structure (TS stubs only)          |
| Done | README draft + CHANGELOG skeleton                         |
| Note | No deps/tooling installed yet                             |
| Next | npm init + deps, prisma init, schema, ESLint, dev scripts |

## 2025-09-21

| Type | Item                                                                                                                     |
| ---- | ------------------------------------------------------------------------------------------------------------------------ |
| Done | Skapat nytt databas-schema för Rimfrost med tabeller för personer, roller, låtar, skivor och utgåvor.                    |
| Done | Lagt till constraints (CHECK, UNIQUE, FOREIGN KEYS) samt index för effektivare sökningar.                                |
| Done | Seedat databasen med initial data för personer, roller, album och kopplingar mellan dessa.                               |
| Note | Datamodellen inkluderar relationer mellan personer och utgåvor samt specifika roller i både produktion och låtskrivande. |
| Next | Fylla på med låtdata och testköra queries för att verifiera att relationerna fungerar korrekt.                           |

## 2025-09-22

| Type | Item                                                                                                 |
| ---- | ---------------------------------------------------------------------------------------------------- |
| Done | Lagt in rollkopplingar (release_credit_role) för samtliga releaser och musiker.                      |
| Done | Seedat hela låtkatalogen med titlar, speltid och ISRC-koder.                                         |
| Done | Registrerat låtskrivare och deras andelar (Fredrik, Sebastian, Jonas, Johan).                        |
| Note | Delningsprocenten är balanserad mellan medlemmarna, med stöd för flera upphovsmän.                   |
| Next | Koppla låtar till specifika releaser via track_list och testa queries för att validera integriteten. |

## 2025-09-23

| Type | Item                                                        |
| ---- | ----------------------------------------------------------- |
| Done | Populerat databasen med data                                |
| Next | Refaktoriserat `rimfrost.sql` till separata migrationsfiler |

## 2025-09-24

| Type | Item                                         |
| ---- | -------------------------------------------- |
| Done | Skapat `persons.route` och `persons.service` |
| Done | Lagt in möjlighet att hämta person via ID    |
| Note | Första stegen på serversidans struktur       |
| Next | Undersöka hur jag ska implementera Prisma    |

| Type | Item                                                                                                  |
| ---- | ----------------------------------------------------------------------------------------------------- |
| Done | Refaktorerat databaslagret: deprekerat `mysql2`-kopplingen och ersatt med Prisma                      |
| Done | Döpt om `src/db/index.ts` → `src/db/index.deprecated.ts` och lagt in deprecation notice               |
| Done | Introducerat `src/db/prismaClient.ts` som ny entrypoint                                               |
| Done | Uppdaterat data layer till Prisma                                                                     |
| Done | Infört `asyncHandler` för centraliserad felhantering                                                  |
| Done | Förbättrat error handler: returnerar endast säkra fält (`err, code, route, status`) till klienten     |
| Note | Error handling är nu både centraliserad (DRY) och säker (inga känsliga detaljer läcker till klienten) |
| Next | Skriva `records.routes`, `records.service` och se till att de fungerar med errorhantering             |

## 2025-09-26

| Type | Item                                                                                                                                                                                                     |
| ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Done | Rensat gammal deprekerad MySQL-logik efter bytet till Prisma                                                                                                                                             |
| Done | Lagt till `idParam`-middleware för centraliserad validering/parsing av `:id`                                                                                                                             |
| Done | Uppdaterat `persons.routes` att använda `idParam`, `PersonNotFoundError` och `makeGetById`                                                                                                               |
| Done | Justerat användningen av `asyncHandler` (fortsatt DRY, modulärt)                                                                                                                                         |
| Done | Centraliserat imports och global `idParam`-registrering (`routes/common.ts`, routers uppdaterade, global `:id` i `app.ts`)                                                                               |
| Fix  | `makeGetById` fallback till `req.params.id` om `res.locals.id` saknas (förhindrar PrismaClientValidationError)                                                                                           |
| Feat | `songs.routes.ts` (lista alla låtar + hämta låt via id), `songs.service.ts` (mappar Prisma-resultat till `SongDTO`), `songs.data.ts` (DB-access), `SongNotFoundError`, `song.types.ts`                   |
| Note | Routes och services är nu mer modulära och återanvänder gemensamma helpers                                                                                                                               |
| Next | Lista ut hur jag ska implementera hämtning av flera kopplade tabeller och hur det ska hanteras i lager (route, service) samt hur JSON-svar kan struktureras med arrayer och objekt baserat på relationer |

## 2025-09-27

| Type | Item                                                                                                                                                                    |
| ---- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Done | Lagt till `findByPersonId` för att hämta alla skivor som tillhör en person                                                                                              |
| Done | Stöd i `GET /api/persons/:id` för `?with=records` och `?with=recordRoles`                                                                                               |
| Done | Stöd i `GET /api/persons` för `?with=records`                                                                                                                           |
| Done | Service inkluderar `release_credit → { record, release_credit_role → role }` och mappar till `PersonDTO.records[]` med `role[]`                                         |
| Done | Infört starka typer: `PersonWithCredits`, `ReleaseCreditWithRecord`                                                                                                     |
| Done | Validerat/whitelistat `with`; mappat `PersonNotFoundError` → `HttpError(404,"PERSON_NOT_FOUND")`                                                                        |
| Done | Fixat relation-filters till `snake_case` (t.ex. `person_id`)                                                                                                            |
| Fix  | Korrigerat felaktiga rollmappningar i `release_credit_role` (säkrat unikhet på `(release_credit_id, role_id)`, rensat och återinsatt korrekt)                           |
| Note | Person-API stöder nu hämtning av records och roller per record; datakvalitet för roller är rättad                                                                       |
| Next | Utöka svar med metadata: antal skivor, antal roller, `mainRole`, `collaborators`, `roleCategories` för `GET /api/persons/:id?with=recordRoles` (ev. även list-endpoint) |

## 2025-09-29

| Type | Item                                                                                                               |
| ---- | ------------------------------------------------------------------------------------------------------------------ |
| Done | Brutit ut meta- och collaborator-logik från `persons.service` till ny `services/meta`-mapp                         |
| Done | Skapat `buildPersonMeta`, `augmentRecordsWithCollaborators`, `attachRecordCollaborators` och utils för beräkningar |
| Done | Förenklat `getPerson` genom att delegera meta och collaborators till de nya services                               |
| Next | Fortsätta bryta ut kod för att göra den mer DRY, med separation of concerns och bättre läsbarhet                   |
