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
