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
