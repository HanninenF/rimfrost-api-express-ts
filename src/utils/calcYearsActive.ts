import type { RecordDTO } from "../types/record.types.js";

export function calcYearsActive(records: RecordDTO[]): number {
  // --- Years active ---
  // Plocka ut alla release_dates och samla in en array
  const dates: Date[] = records.map((r) => new Date(r.release_date));
  let years_active = 0;
  if (dates.length) {
    // Räkna ut tidigast och senast datum
    const minDate = new Date(Math.min(...dates.map((d) => d.getTime())));
    const maxDate = new Date(Math.max(...dates.map((d) => d.getTime())));

    //räkna ut antal år mellan tidigast och senast datum
    let years = maxDate.getFullYear() - minDate.getFullYear();

    /* maxDateMånad mindre än minDateMånad eller
    maxDateMånad är lika med minDateMånad och 
    maxDate är mindre än minDate.
    (Månad) 2016-04-22 < 2015-09-01 eller
    (dag) 2016-04-01 < 2015-04-22
    */
    const beforeAnniversary =
      maxDate.getMonth() < minDate.getMonth() ||
      (maxDate.getMonth() === minDate.getMonth() &&
        maxDate.getDate() < minDate.getDate());

    if (beforeAnniversary) years--;
    years_active = Math.max(1, years + 1);
  }
  return years_active;
}
