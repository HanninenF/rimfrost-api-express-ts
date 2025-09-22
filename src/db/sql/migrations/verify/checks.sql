SELECT
  (SELECT COUNT(*) FROM person) AS person_count,
  (SELECT COUNT(*) FROM record) AS record_count,
  (SELECT COUNT(*) FROM role) AS role_count,
  (SELECT COUNT(*) FROM song) AS song_count,
  (SELECT COUNT(*) FROM record_format) AS record_format_count,
  (SELECT COUNT(*) FROM release_credit) AS release_credit_count,
  (SELECT COUNT(*) FROM release_credit_role) AS release_credit_role_count,
  (SELECT COUNT(*) FROM song_writer) AS song_writer_count,
  (SELECT COUNT(*) FROM song_writer_role) AS song_writer_role_count,
  (SELECT COUNT(*) FROM track_list) AS track_list_count,
  (SELECT COUNT(*) FROM edition) AS edition_count;
