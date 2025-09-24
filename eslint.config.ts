// eslint.config.js (eller .mjs)
import js from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";
import { defineConfig } from "eslint/config";

export default defineConfig([
  // Ignorera build-output
  { ignores: ["dist/**", "eslint.config.ts"] },

  // TypeScript-rekommendationer (parser + plugin ingår)
  ...tseslint.configs.recommended,

  // JS-rekommendationer för .js-filer
  {
    files: ["**/*.{js,mjs,cjs}"],
    ...js.configs.recommended,
  },

  // Node-globals (gäller allt)
  {
    languageOptions: { globals: globals.node },
  },

  // TS-specifika: type-aware parsing + din regel
  {
    files: ["**/*.{ts,mts,cts}"],
    languageOptions: {
      parserOptions: { project: "./tsconfig.json" },
    },
    rules: {
      "@typescript-eslint/explicit-function-return-type": "error",
      "@typescript-eslint/no-unused-vars": [
        "error",
        { argsIgnorePattern: "^_" },
      ],
    },
  },
]);
