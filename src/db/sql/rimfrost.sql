











-- Create relation table song_writer (FK: person, song)
DROP TABLE IF EXISTS song_writer;

CREATE TABLE song_writer (
  id INT AUTO_INCREMENT PRIMARY KEY,
  person_id INT NOT NULL,
  song_id INT NOT NULL,
  share_percent DECIMAL(5,2),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  FOREIGN KEY (person_id) REFERENCES person(id),
  FOREIGN KEY (song_id) REFERENCES song(id),
  UNIQUE (person_id, song_id),
  CHECK (share_percent IS NULL OR (share_percent BETWEEN 0 AND 100))
);

-- Create song_writer_roles
DROP TABLE IF EXISTS song_writer_role;

CREATE TABLE song_writer_role (
  id INT AUTO_INCREMENT PRIMARY KEY,
  song_writer_id INT NOT NULL,
  role_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  FOREIGN KEY (song_writer_id) REFERENCES song_writer(id),
  FOREIGN KEY (role_id) REFERENCES role(id),
  UNIQUE (song_writer_id, role_id)
);

-- Insert song_writer_roles
INSERT INTO song_writer_role (song_writer_id, role_id) VALUES
-- Hänninen
(1,15),(1,16),
(3,15),(3,16),
(5,15),(5,16),
(7,15),(7,16),
(9,15),(9,16),
(11,15),(11,16),
(13,15),(13,16),
(15,15),(15,16),
(17,15),(17,16),
(19,15),(19,16),
(21,15),(21,16),
(24,15),(24,16),
(26,15),(26,16),
(28,15),(28,16),
(30,15),(30,16),
(32,15),(32,16),
(34,15),(34,16),
(36,15),(36,16),
(38,15),(38,16),
(40,15),(40,16),
(42,15),(42,16),
(45,15),(45,16),
(47,15),(47,16),
(49,15),(49,16),
(52,15),(52,16);

INSERT INTO song_writer_role (song_writer_id, role_id) VALUES
-- Svedlund
(2,15),(2,16),
(4,15),(4,16),
(6,15),(6,16),
(8,15),(8,16),
(10,15),(10,16),
(12,15),(12,16),
(14,15),(14,16),
(16,15),(16,16),
(18,15),(18,16),
(20,15),(20,16),
(22,15),(22,16),
(25,15),(25,16),
(27,15),(27,16),
(29,15),(29,16),
(31,15),(31,16),
(33,15),(33,16),
(35,15),(35,16),
(37,15),(37,16),
(39,15),(39,16),
(41,15),(41,16),
(43,15),(43,16),
(46,15),(46,16),
(48,15),(48,16),
(50,15),(50,16),
(53,15),(53,16);

INSERT INTO song_writer_role (song_writer_id, role_id) VALUES
-- Lettenström
(44,16),
(51,16),
-- Påhlsson
(23,15);




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

--Create track_list
DROP TABLE IF EXISTS track_list;

CREATE TABLE track_list (
  id INT AUTO_INCREMENT PRIMARY KEY,
  song_id INT NOT NULL,
  release_id INT NOT NULL,
  track_number INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  FOREIGN KEY (song_id) REFERENCES song(id),
  FOREIGN KEY (release_id) REFERENCES record(id),
  UNIQUE (release_id, track_number),
  UNIQUE (release_id, song_id),
  CHECK (track_number >= 1)
);

INSERT INTO track_list (release_id, song_id, track_number) VALUES
-- Unredeemed Demons (id= 1)
/*
r.id,s.id,tn*/
(1,6,1), -- Silence Reign in Winter Realm 
(1,7,2), -- The Arctic Kingdom Rises 
(1,8,3), -- Unredeemed Demons   
(1,9,4), -- Snön Färgas Röd Av Blod 
-- A Frozen World Unknown (id= 2)
(2,3,1), -- Freezing Inferno  
(2,1,2), -- At the Mighty Halls They'll Walk 
(2,4,3), -- Ride the Storm    
(2,2,4), -- A Frozen World Unknown 
(2,5,5), -- Hordes of Rime     
-- Veraldar Nagli (id= 3)
(3,10,1), -- Veraldar Nagli 
(3,11,2), -- The Black Death  
(3,12,3), -- The Raventhrone
(3,13,4), -- Legacy Through Blood
(3,14,5), -- Mountains Of Mána
(3,15,6), -- I Stand My Ground
(3,16,7), -- Scandinavium
(3,17,8), -- Void Of Time
-- Rimfrost (id= 4)
(4,18,1), -- As The Silver Curtain Closes
(4,19,2), -- Saga North
(4,20,3), -- Beyond The Mountains Of Rime
(4,21,4), -- Dark Prophecies
(4,22,5), -- Ragnarök
(4,23,6), -- Cold
(4,24,7), -- Witches Hammer
(4,25,8); -- Frostlaid Skies


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



-- insert record_formats
INSERT INTO record_format (format_type, category) VALUES
('CD','Physical'),
('Vinyl 7"','Physical'),
('Vinyl 10"','Physical'),
('Vinyl 12"','Physical'),
('Cassette','Physical'),
('DVD','Physical'),
('Blu-ray','Physical'),
('Box Set','Physical'),
('Limited Edition','Special Edition'),
('Deluxe Edition','Special Edition'),
('Promo','Special Edition'),
('Digital Download','Digital'),
('Streaming','Digital');
    

SELECT 
id,
format_type,
category
FROM record_format
ORDER BY id;

-- Create relation edition
DROP TABLE IF EXISTS edition;

CREATE TABLE edition (
  id INT AUTO_INCREMENT PRIMARY KEY,
  release_id INT NOT NULL,
  format_id INT NOT NULL,
  edition_name VARCHAR(20) NOT NULL,       -- får vara '' men inte NULL
  catalog_number VARCHAR(30),
  barcode_upc_ean VARCHAR(20),
  edition_date DATE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  FOREIGN KEY (release_id) REFERENCES record(id),
  FOREIGN KEY (format_id)  REFERENCES record_format(id),
  UNIQUE (barcode_upc_ean),
  UNIQUE (release_id, format_id, catalog_number),
  CHECK (catalog_number IS NULL OR catalog_number <> ''),
  CHECK (barcode_upc_ean IS NULL OR barcode_upc_ean <> '')
);

-- Insert editions
INSERT INTO edition (release_id, format_id, edition_name, catalog_number, barcode_upc_ean, edition_date) VALUES
/*
(id= 1) Unredeemed Demons  
*/
(1,1,'',NULL,NULL,'2003-11-01'), /*CD*/
/*
(id= 2) A Frozen World Unknown  
*/
(2,1,'','NC115','4025858029559','2006-10-28'), /*CD*/
(2,13,'',NULL,'195036648439','2009-11-16'), /*Streaming*/
/*
(id= 3) Veraldar Nagli 
*/
(3,1,'','SUA007','822603180725','2009-11-16'), /*CD*/
(3,11,'Cardboard','SUA007',NULL,'2009-11-16'), /*Promo*/
(3,13,'','SUA007','886443774308','2009-11-16'), /*Streaming*/
/*
(id= 4) Rimfrost  
*/
(4,1,'','NSR013','8714835113799','2016-03-25'), /*CD*/
(4,12,'FLAC',NULL,NULL,'2016-03-25'), /*Digital Download*/
(4,12,'MP3',NULL,NULL,'2016-03-25'); /*Digital Download*/


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

-- Insert persons
INSERT INTO person (first_name, alias, last_name, ipi_number)
VALUES 
('Fredrik', 'Throllv', 'Hänninen', '595171915'),
('Sebastian', 'Hravn', 'Svedlund', '485000966'),
('Thomas', 'Tjopme', 'Josefsson', '503180104'),
('Tobias', 'Khratos', 'Oja', '698386275'),
('Jonas', 'B.C.', 'Lettenström', '792954193'),
('Mikael', 'Micke', 'Andersson', NULL),
('Jonas', NULL, 'Kjellgren', NULL),
('Viktor', NULL, 'Rickan', NULL),
('Peter', NULL, 'Laustsen', NULL),
('Johan', 'Beuwolf', 'Påhlsson', NULL),
('Andreas', NULL, 'Åsfeldt', NULL),
('Martina', 'NecroArt', 'Sandström', NULL),
('Ricardo', NULL, 'Gelok', NULL),
('Istvan', NULL, 'Konya', NULL),
('Anders Lars-Erik', 'Andy La Rocque', 'Allhage', NULL),
('Jimmie', 'Sorghim', 'Karlsson', NULL),
('Marcus', NULL, 'Gullberg', NULL),
('Joakim', NULL, 'Ericsson', NULL);

-- Insert records
INSERT INTO record (title, release_date) VALUES
('Unredeemed Demons', '2003-11-01'),
('A Frozen World Unknown', '2006-10-28'),
('Veraldar Nagli', '2009-11-16'),
('Rimfrost', '2016-03-25');


-- Insert release_credits
INSERT INTO release_credit (person_id, release_id) VALUES
/*person_id 1= Fredrik*/
(1,1), /* Unredeemed Demons */
(1,2), /* A Frozen World Unknown */
(1,3), /* Veraldar Nagli */
(1,4), /* Rimfrost    */
/*person_id 2= Sebastian*/
(2,1), /* Unredeemed Demons */
(2,2), /* A Frozen World Unknown */
(2,3), /* Veraldar Nagli */
(2,4), /* Rimfrost    */
/*person_id 5= Jonas*/
(5,4),
/*person_id 6= Mikael*/
(6,4),
/*person_id 7= Kjellgren*/
(7,2),
/*person_id 8= Viktor*/
(8,3),
/*person_id 9= Peter*/
(9,3),
/*person_id 10= Johan*/
(10,2),
/*person_id 11= Andreas*/
(11,2),
/*person_id 12= Martina*/
(12,2), /* A Frozen World Unknown */
(12,3), /* Veraldar Nagli */
(12,4), /* Rimfrost    */
/*person_id 13= Ricardo*/
(13,4),
/*person_id 14= Istvan*/
(14,4),
/*person_id 15= Anders*/
(15,3),
/*person_id 16= Jimmie*/
(16,1),
/*person_id 17= Marcus*/
(17,1),
/*person_id 18= Joakim*/
(18,1);

-- insert roles
INSERT INTO role (role_title, category) VALUES
('Vocals','Performance'),
('Backing Vocals','Performance'),
('Guitars','Performance'),
('Bass','Performance'),
('Drums','Performance'),
('Keys','Performance'),
('Producer','Production'),
('Mixing Engineer','Production'),
('Mastering Engineer', 'Production'),
('Recording Engineer','Production'),
('Cover Artwork','Production'),
('Illustration','Production'),
('Booklet Design','Production'),
('Photography','Production'),
('Music','Songwriting'),
('Lyrics','Songwriting'),
('Arrangement','Songwriting'),
('Orchestration','Songwriting');


-- Insert release_credit_role
INSERT INTO release_credit_role (release_credit_id, role_id)VALUES
/*Fredrik A frozen*/
(1,5),/*Drums*/
(1,2),/*Backing Vocals*/
/*Sebastian a frozen*/
(2,1),/*Vocals*/
(2,3),/*Guitars*/
(2,2),/*Backing Vocals*/
/*Andreas åsfeldt a frozen*/
(3,11),/*Cover Artwork*/
(3,13),/*Photography*/
/*Johan a frozen*/
(4,4),/*Bass*/
(4,2),/*Backing Vocals*/
/*Jonas a frozen*/
(5,8),/*Mixing Engineer*/
(5,9),/*Mastering Engineer*/
(5,6),/*Keys*/
(5,2),/*Backing Vocals*/
(5,7),/*Producer*/
(5,10),/*Recording Engineer*/
/*Martina a frozen*/
(6,14),/*Photography*/
/*Fredrik Veraldar*/
(7,5),/*Drums*/
(7,2),/*Backing Vocals*/
(7,6),/*Keys*/
(7,7),/*Producer*/
/*Sebastian Veraldar*/
(8,1),/*Vocals*/
(8,3),/*Guitars*/
(8,2),/*Backing Vocals*/
(8,6),/*Keys*/
(8,7),/*Producer*/
/*Viktor Veraldar*/
(9,11),/*Cover Artwork*/
(9,13),/*Booklet Design*/
/*Peter Veraldar*/
(10,4),/*Bass*/
(10,10),/*Recording Engineer*/
/*Andy Veraldar*/    
(11,7),/*Producer*/
(11,8),/*Mixing Engineer*/
(11,9),/*Mastering Engineer*/
/*Martina Veraldar*/
(12,14),/*Photography*/
/*Fredrik Rimfrost*/
(18,5),/*Drums*/
(18,2),/*Backing Vocals*/
(18,1),/*Vocals*/
(18,6),/*Keys*/
(18,7),/*Producer*/
(18,10),/*Recording Engineer*/
/*Sebastian Rimfrost*/
(19,1),/*Vocals*/
(19,3),/*Guitars*/
(19,2),/*Backing Vocals*/
(19,7),/*Producer*/
(19,14),/*Photography*/
/*Jonas Rimfrost*/
(20,4),/*Bass*/
(20,2),/*Backing Vocals*/
(20,7),/*Producer*/
/*Micke Rimfrost*/
(21,8),/*Mixing Engineer*/
(21,9),/*Mastering Engineer*/
(21,10),/*Recording Engineer*/
/*Martina Rimfrost*/
(22,14),/*Photography*/
/*Ricardo Rimfrost*/
(23,13),/*Booklet Design*/
/*Istvan Rimfrost*/
(24,12),/*Illustration*/
/*Fredrik Unredeemed*/
(13,5),/*Drums*/
(13,3),/*Guitars*/
/*Sebastian Unredeemed*/
(14,1),/*Vocals*/
(14,3),/*Guitars*/
/*Jimmie Unredeemed*/
(15,4),/*Bass*/
/*Marcus Unredeemed*/
(16,11),/*Cover Artwork*/
(16,13),/*Booklet Design*/
/*Jocke Unredeemed*/
(17,14);/*Photography*/

-- Insert songs
INSERT INTO song (title, duration, isrc) VALUES
  ('At the Mighty Halls They''ll Walk', 371, 'QZK6N1983546'),
  ('A Frozen World Unknown', 462, 'QZK6N1983542'),
  ('Freezing Inferno', 528, 'QZK6N1983539'),
  ('Ride the Storm', 451, 'QZK6N1983541'),
  ('Hordes of Rime', 448, 'QZK6N1983543'),
  ('Silence Reign in Winter Realm', 415, NULL),
  ('The Arctic Kingdom Rises', 331, NULL),
  ('Unredeemed Demons', 353, NULL),
  ('Snön Färgas Röd Av Blod', 247, NULL),
  ('Veraldar Nagli', 380, 'FR33T0980701'),
  ('The Black Death', 288, 'FR33T0980702'),
  ('The Raventhrone', 390, 'FR33T0980703'),
  ('Legacy Through Blood', 535, 'FR33T0980704'),
  ('Mountains Of Mána', 295, 'FR33T0980705'),
  ('I Stand My Ground', 335, 'FR33T0980706'),
  ('Scandinavium', 494, 'FR33T0980707'),
  ('Void Of Time', 443, 'FR33T0980708'),
  ('As The Silver Curtain Closes', 482, 'ESA011988895'),
  ('Saga North', 402, 'ESA011988896'),
  ('Beyond The Mountains Of Rime', 288, 'ESA011988897'),
  ('Dark Prophecies', 333, 'ESA011988898'),
  ('Ragnarök', 383, 'ESA011988899'),
  ('Cold', 250, 'ESA011988900'),
  ('Witches Hammer', 361, 'ESA011988901'),
  ('Frostlaid Skies', 548, 'ESA011988902');

-- insert songwriters
START TRANSACTION;

SET @fredrik:= (SELECT 
id 
FROM person 
WHERE first_name='Fredrik' 
AND last_name='Hänninen');
SET @sebastian:= (SELECT 
id 
FROM person 
WHERE first_name='Sebastian' 
AND last_name='Svedlund');
SET @jonas:= (SELECT 
id 
FROM person 
WHERE first_name='Jonas'     
AND last_name='Lettenström');
SET @johan:= (SELECT 
id 
FROM person 
WHERE first_name='Johan'     
AND last_name='Påhlsson');


INSERT INTO song_writer (song_id, person_id, share_percent) VALUES
-- 1 At the Mighty Halls They'll Walk
(1,@fredrik,50.00),(1,@sebastian,50.00),
-- 2 A Frozen World Unknown
(2,@fredrik,50.00),(2,@sebastian,50.00),
-- 3 Freezing Inferno
(3,@fredrik,50.00),(3,@sebastian,50.00),
-- 4 Ride the Storm
(4,@fredrik,50.00),(4,@sebastian,50.00),
-- 5 Hordes of Rime
(5,@fredrik,50.00),(5,@sebastian,50.00),
-- 6 Silence Reign in Winter Realm
(6,@fredrik,50.00),(6,@sebastian,50.00),
-- 7 The Arctic Kingdom Rises
(7,@fredrik,50.00),(7,@sebastian,50.00),
-- 8 Unredeemed Demons
(8,@fredrik,50.00),(8,@sebastian,50.00),
-- 9 Snön Färgas Röd Av Blod
(9,@fredrik,50.00),(9,@sebastian,50.00),
-- 10 Veraldar Nagli
(10,@fredrik,50.00),(10,@sebastian,50.00),
-- 11 The Black Death
(11,@fredrik,50.00),(11,@sebastian,50.00),(11,@johan,0.00),
-- 12 The Raventhrone
(12,@fredrik,50.00),(12,@sebastian,50.00),
-- 13 Legacy Through Blood
(13,@fredrik,50.00),(13,@sebastian,50.00),
-- 14 Mountains Of Mána
(14,@fredrik,50.00),(14,@sebastian,50.00),
-- 15 I Stand My Ground
(15,@fredrik,50.00),(15,@sebastian,50.00),
-- 16 Scandinavium
(16,@fredrik,50.00),(16,@sebastian,50.00),
-- 17 Void Of Time
(17,@fredrik,50.00),(17,@sebastian,50.00),
-- 18 As The Silver Curtain Closes
(18,@fredrik,50.00),(18,@sebastian,50.00),
-- 19 Saga North
(19,@fredrik,50.00),(19,@sebastian,50.00),
-- 20 Beyond The Mountains Of Rime
(20,@fredrik,50.00),(20,@sebastian,50.00),
-- 21 Dark Prophecies
(21,@fredrik,34.00),(21,@sebastian,34.00),(21,@jonas,32.00),
-- 22 Ragnarök
(22,@fredrik,50.00),(22,@sebastian,50.00),
-- 23 Cold
(23,@fredrik,50.00),(23,@sebastian,50.00),
-- 24 Witches Hammer
(24,@fredrik,34.00),(24,@sebastian,34.00),(24,@jonas,32.00),
-- 25 Frostlaid Skies
(25,@fredrik,50.00),(25,@sebastian,50.00);

COMMIT;
           