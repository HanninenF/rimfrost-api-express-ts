/* import type { Song, SongDTO } from "../types/song.types.js";
import * as songData from "../data/songs.data.js";
import { SongNotFoundError } from "../errors/NotFoundErrors.js";

const toDTO = (s: Song): SongDTO => {
  return {
    id: s.id,
    title: s.title,
    duration: s.duration,
    isrc: s.isrc ? s.isrc : null,
    created_at:
      s.created_at instanceof Date ? s.created_at.toISOString() : s.created_at,
    updated_at:
      s.updated_at instanceof Date ? s.updated_at.toISOString() : s.updated_at,
  };
};

// Business logic och data transformation
export const getAllSongs = async (): Promise<SongDTO[]> => {
  const rows: Song[] = await songData.findAll();

  return rows.map(toDTO);
};

export const getSongById = async (id: number): Promise<SongDTO | null> => {
  const row: Song | null = await songData.findById(id);

  if (!row) {
    throw new SongNotFoundError(id);
  }
  return toDTO(row);
};
 */
