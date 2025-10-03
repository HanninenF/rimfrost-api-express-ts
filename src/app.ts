import personRouter from "./routes/persons.routes.js";
import recordRouter from "./routes/records.routes.js";
import songRouter from "./routes/songs.routes.js";
import { errorHandler, express, idParam } from "./routes/common.js";
import prisma from "./db/prismaClient.js";
import cors from "cors";

const app = express();
const PORT: number = Number(process.env.PORT) || 3000;

app.use(cors({ origin: "http://localhost:4200" }));
app.param("id", idParam);
app.use("/api/persons", personRouter);
app.use("/api/records", recordRouter);
app.use("/api/songs", songRouter);
app.use(errorHandler);

const server = app.listen(PORT, () => {
  console.log(`Servern körs på ${PORT}`);
});

let hardTimer: NodeJS.Timeout | null = null;
let shuttingDown = false;

function closeServer(): Promise<void> {
  return new Promise((resolve, reject) => {
    server.close((err) => (err ? reject(err) : resolve()));
  });
}

async function shutdown(signal: string): Promise<void> {
  if (shuttingDown) return; // idempotent
  shuttingDown = true;

  console.log(`[${signal}] graceful shutdown...`);

  // starta hård timeout *endast nu*
  hardTimer = setTimeout(() => {
    console.warn("Tvingad nedstängning (timeout).");
    process.exit(1);
  }, 10_000).unref();

  try {
    await closeServer();
  } catch (err) {
    const e = err instanceof Error ? err : new Error(String(err));
    console.error("[shutdown] closeServer failed:", e.stack ?? e.message);
    process.exitCode = 1; // markera felaktig exit
  } finally {
    try {
      await prisma.$disconnect();
    } catch (err) {
      const e = err instanceof Error ? err : new Error(String(err));
      console.error("[shutdown] closeServer failed:", e.stack ?? e.message);
      process.exitCode = 1;
    }
    if (hardTimer) clearTimeout(hardTimer);
    setTimeout(() => process.exit(process.exitCode ?? 0), 100).unref();
  }
}

process.once("SIGINT", () => shutdown("SIGINT"));
process.once("SIGTERM", () => shutdown("SIGTERM"));

// Kör för varje ohanterat promise-fel (eller byt till .once om du bara vill ta första)
process.on("unhandledRejection", (reason, _promise) => {
  console.error("[unhandledRejection]", reason);
  void shutdown("unhandledRejection");
});

// fånga sync-fel
process.on("uncaughtException", (err) => {
  console.error("[uncaughtException]", err);
  void shutdown("uncaughtException");
});
