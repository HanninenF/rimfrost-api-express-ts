
-- (safe, idempotent)
USE rimfrost_db;
SELECT
(SELECT COUNT(*) FROM person) AS p_count,
(SELECT COUNT(*) FROM record) AS r_count,
(SELECT COUNT(*) FROM role) AS ro_count,
(SELECT COUNT(*) FROM song) AS s_count,
(SELECT COUNT(*) FROM record_format) AS f_count,
(SELECT COUNT(*) FROM release_credit) AS rc_count,
(SELECT COUNT(*) FROM release_credit_role) AS rcr_count,
(SELECT COUNT(*) FROM song_writer) AS sw_count,
(SELECT COUNT(*) FROM song_writer_role) AS swr_count,
(SELECT COUNT(*) FROM track_list) AS tl_count,
(SELECT COUNT(*) FROM edition) AS e_count;
