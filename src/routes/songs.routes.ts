import type { SongDTO } from "../types/song.types.js";
import { asyncHandler, express, makeGetById } from "./common.js";

import * as songService from "../services/songs.service.js";
import { SongNotFoundError } from "../errors/NotFoundErrors.js";

const router = express.Router();

// GET /api/songs - Alla personer
router.get(
  "/",
  asyncHandler(async (_req, res) => {
    const songs: SongDTO[] = await songService.getAllSongs();
    res.json(songs);
  })
);

// GET /api/songs/:id
router.get(
  "/:id",
  asyncHandler(
    makeGetById(
      songService.getSongById,
      SongNotFoundError,
      "SONG_NOT_FOUND",
      "Song"
    )
  )
);

export default router;
