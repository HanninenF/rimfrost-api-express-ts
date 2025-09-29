/** Payload vid skapande (POST) */
export type NewRecord = {
  title: string;
  release_date: string;
};

/** Payload vid uppdatering (PATCH) */
export type UpdateRecord = Partial<NewRecord>;

export type TrackDTO = {
  id: number;
  song_id: number;
  release_id: number;
  track_number: number;
  song: SongDTO;
  created_at: string;
  updated_at: string;
};

export type RecordMetaDTO = {
  collaborators: PersonDTO[];
};

/** Det vi skickar ut från API:t (service lägger till ...) */
export type RecordDTO = {
  id: number;
  title: string;
  release_date: string;
  created_at: string;
  updated_at: string;
  role?: RoleDTO[];
  track_list?: TrackDTO[];
  meta?: RecordMetaDTO;
};

/* Prisma types */

// typer – type-only import är ok
import type { Prisma } from "../generated/prisma/index.js";
import type { PersonDTO } from "./person.types.js";
import type { RoleDTO } from "./role.types.js";
import type { SongDTO } from "./song.types.js";

export type RecordModel = Prisma.recordGetPayload<true>;
