import type { RecordDTO, Record } from "../types/record.types.js";
import * as recordData from "../data/records.data.js";
import { RecordNotFoundError } from "../errors/NotFoundErrors.js";

const toDTO = (r: Record): RecordDTO => {
  return {
    id: r.id,
    title: r.title,
    release_date:
      r.release_date instanceof Date
        ? r.release_date.toISOString()
        : (r.release_date as unknown as string),
    created_at:
      r.release_date instanceof Date
        ? r.created_at.toISOString()
        : (r.created_at as unknown as string),
    updated_at:
      r.updated_at instanceof Date
        ? r.updated_at.toISOString()
        : (r.updated_at as unknown as string),
  };
};

// Business logic och data transformation
export const getAllRecords = async (): Promise<RecordDTO[]> => {
  const rows: Record[] = await recordData.findAll();
  return rows.map(toDTO);
};

export const getRecordById = async (id: number): Promise<RecordDTO | null> => {
  const row: Record | null = await recordData.findById(id);

  if (!row) {
    throw new RecordNotFoundError(id);
  }
  return toDTO(row);
};
