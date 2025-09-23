import express from "express";
import personRouter from "./routes/persons.routes.js";
const app = express();
const PORT: string | number = process.env.PORT || 3000;

app.use("/api/persons", personRouter);

app.listen(PORT, () => {
  console.log(`Servern körs på ${PORT}`);
});
