
SET NAMES utf8mb4;
-- (safe, idempotent)
USE rimfrost_db;

-- Hänninen & Svedlund: båda rollerna
INSERT INTO song_writer_role (song_writer_id, role_id)
SELECT sw.id, r.id
FROM song_writer sw
JOIN person p ON p.id = sw.person_id
JOIN role r ON r.role_title IN ('Music','Lyrics')
LEFT JOIN song_writer_role srl
  ON srl.song_writer_id = sw.id AND srl.role_id = r.id
WHERE p.last_name IN ('Hänninen','Svedlund')
  AND srl.id IS NULL;

-- Lettenström: bara Lyrics
INSERT INTO song_writer_role (song_writer_id, role_id)
SELECT sw.id, r.id
FROM song_writer sw
JOIN person p ON p.id = sw.person_id
JOIN role r ON r.role_title = 'Lyrics'
LEFT JOIN song_writer_role srl
  ON srl.song_writer_id = sw.id AND srl.role_id = r.id
WHERE p.last_name = 'Lettenström'
  AND srl.id IS NULL;

-- Påhlsson: bara Music
INSERT INTO song_writer_role (song_writer_id, role_id)
SELECT sw.id, r.id
FROM song_writer sw
JOIN person p ON p.id = sw.person_id
JOIN role r ON r.role_title = 'Music'
LEFT JOIN song_writer_role srl
  ON srl.song_writer_id = sw.id AND srl.role_id = r.id
WHERE p.last_name = 'Påhlsson'
  AND srl.id IS NULL;
