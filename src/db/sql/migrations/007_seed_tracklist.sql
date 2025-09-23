SET NAMES utf8mb4;

USE rimfrost_db;

-- Unredeemed Demons (release: "Unredeemed Demons")
INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 1
FROM record r
JOIN song s ON s.title = 'Silence Reign in Winter Realm'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'Unredeemed Demons' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 2
FROM record r
JOIN song s ON s.title = 'The Arctic Kingdom Rises'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'Unredeemed Demons' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 3
FROM record r
JOIN song s ON s.title = 'Unredeemed Demons'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'Unredeemed Demons' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 4
FROM record r
JOIN song s ON s.title = 'Snön Färgas Röd Av Blod'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'Unredeemed Demons' AND tl.id IS NULL;


-- A Frozen World Unknown
INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 1
FROM record r
JOIN song s ON s.title = 'Freezing Inferno'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'A Frozen World Unknown' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 2
FROM record r
JOIN song s ON s.title = 'At the Mighty Halls They''ll Walk'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'A Frozen World Unknown' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 3
FROM record r
JOIN song s ON s.title = 'Ride the Storm'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'A Frozen World Unknown' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 4
FROM record r
JOIN song s ON s.title = 'A Frozen World Unknown'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'A Frozen World Unknown' AND tl.id IS NULL;

INSERT INTO track_list (release_id, song_id, track_number)
SELECT r.id, s.id, 5
FROM record r
JOIN song s ON s.title = 'Hordes of Rime'
LEFT JOIN track_list tl ON tl.release_id = r.id AND tl.song_id = s.id
WHERE r.title = 'A Frozen World Unknown' AND tl.id IS NULL;


-- Veraldar Nagli
-- (upprepa samma mönster för alla 8 spår)


-- Rimfrost
-- (upprepa samma mönster för alla 8 spår)
