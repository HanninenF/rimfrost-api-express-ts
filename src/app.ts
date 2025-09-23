import express from "express";
/* import personRouter from "./routes/monsters.routes.js"; */
const app = express();
const PORT: string | number = process.env.PORT || 3000;

/* app.use("/api/monsters", personRouter); */

app.listen(PORT, () => {
  console.log(`Servern körs på ${PORT}`);
});
