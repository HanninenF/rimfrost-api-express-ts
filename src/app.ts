import personRouter from "./routes/persons.routes.js";
import recordRouter from "./routes/records.routes.js";
import songRouter from "./routes/songs.routes.js";
import { errorHandler, express, idParam } from "./routes/common.js";

const app = express();
const PORT: string | number = process.env.PORT || 3000;

app.param("id", idParam);
app.use("/api/persons", personRouter);
app.use("/api/records", recordRouter);
app.use("/api/songs", songRouter);

app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Servern körs på ${PORT}`);
});
