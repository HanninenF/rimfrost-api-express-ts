
SELECT 
sw.id AS sw_id,
r.id AS r_id,
r.role_title,
p.id AS p_id,
p.last_name, 
s.id AS s_id,
  TRIM(
    REGEXP_REPLACE(
      REPLACE(s.title, '''', ''), 
      '(?<=\\s)(\\p{L})[\\p{L}''-]*',   -- bara ord efter ett mellanslag
      '$1'
    )
  ) AS s_title
FROM role r
INNER JOIN song_writer_role swr ON swr.role_id=r.id
INNER JOIN song_writer sw ON sw.id=swr.song_writer_id
INNER JOIN song s ON sw.song_id=s.id
INNER JOIN person p ON sw.person_id=p.id 
ORDER BY p.id,sw_id, r.id;

SELECT 
id,
role_title
FROM role
ORDER BY id;

SELECT 
id,
person_id,
song_id
FROM song_writer
order by id;

SELECT 
id,
first_name,
last_name
FROM person
order by id;

SELECT 
sw.id as sw_id,
p.id AS p_id,
p.last_name,
s.id AS s_id,
  TRIM(
    REGEXP_REPLACE(
      REPLACE(s.title, '''', ''), 
      '(?<=\\s)(\\p{L})[\\p{L}''-]*',   -- bara ord efter ett mellanslag
      '$1'
    )
  ) AS s_title
FROM person p
INNER JOIN song_writer sw ON sw.person_id=p.id
INNER JOIN song s ON s.id=sw.song_id
ORDER BY p.id, sw.id,s.id,p.last_name, p.first_name;


SELECT 
r.id AS r_id,
r.title AS r_title,
s.id AS s_id,
  TRIM(
    REGEXP_REPLACE(
      REPLACE(s.title, '''', ''), 
      '(?<=\\s)(\\p{L})[\\p{L}''-]*',   -- bara ord efter ett mellanslag
      '$1'
    )
  ) AS s_title,
tl.track_number AS t_nr
FROM record r
INNER JOIN track_list tl ON tl.release_id=r.id
INNER JOIN song s ON s.id=tl.song_id
ORDER BY r.id, track_number;




SELECT 
id,
format_type,
category
FROM record_format
ORDER BY id;


SELECT 
e.id AS e_id,
e.edition_name AS e_name,
  TRIM(
    REGEXP_REPLACE(
      REPLACE(r.title, '''', ''), 
      '(?<=\\s)(\\p{L})[\\p{L}''-]*',   -- bara ord efter ett mellanslag
      '$1'
    )
  ) AS r_title,
TRIM(
    REGEXP_REPLACE(
      REPLACE(rf.format_type, '''', ''), 
      '(?<=\\s)(\\p{L})[\\p{L}''-]*',   -- bara ord efter ett mellanslag
      '$1'
    )
  )  AS format,
rf.category AS f_category
FROM edition e
INNER JOIN record r ON r.id=e.release_id
INNER JOIN record_format rf ON rf.id=e.format_id
ORDER BY e.id,r.id;















           