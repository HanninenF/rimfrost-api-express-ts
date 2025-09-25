import express from "express";
import personRouter from "./routes/persons.routes.js";
import recordRouter from "./routes/records.routes.js";

import errorHandler from "./middleware/errorHandler.js";
const app = express();
const PORT: string | number = process.env.PORT || 3000;

app.use("/api/persons", personRouter);
app.use("/api/records", recordRouter);

app.use(errorHandler);
app.listen(PORT, () => {
  console.log(`Servern körs på ${PORT}`);
});
