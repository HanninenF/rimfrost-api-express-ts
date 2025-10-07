// routes/common.ts
import express from "express";

export { default as idParam } from "../middleware/idParam.js";
export { default as errorHandler } from "../middleware/errorHandler.js";
// Re-export Express för att slippa importera varje gång
export { express };
