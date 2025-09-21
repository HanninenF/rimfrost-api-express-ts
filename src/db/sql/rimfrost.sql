
CREATE DATABASE IF NOT EXISTS rimfrost_db
DEFAULT CHARACTER SET utf8mb4;
USE rimfrost_db;

DROP TABLE IF EXISTS person;

CREATE TABLE person (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  alias      VARCHAR(50) NULL,
  last_name  VARCHAR(50) NOT NULL,
  ipi_number VARCHAR(20),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
             ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT chk_first_name_nonempty CHECK (first_name <> ''),
  CONSTRAINT chk_last_name_nonempty  CHECK (last_name  <> ''),
  -- constraints
  CONSTRAINT chk_alias_nonempty CHECK (alias IS NULL OR alias <> ''),
  CONSTRAINT uq_ipi_number UNIQUE (ipi_number),
  INDEX idx_person_name (last_name, first_name)
);

DROP TABLE IF EXISTS record;

CREATE TABLE record (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  release_date DATE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  CONSTRAINT chk_record_title_nonempty CHECK (title <> ''),
  INDEX idx_record_title_release_date (title, release_date)
); 

DROP TABLE IF EXISTS release_credit;

CREATE TABLE release_credit (
  id INT AUTO_INCREMENT PRIMARY KEY,
  person_id INT NOT NULL,
  release_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  FOREIGN KEY (person_id) REFERENCES person(id),
  FOREIGN KEY (release_id) REFERENCES record(id),
  UNIQUE (person_id, release_id)
);

-- Create table role
DROP TABLE IF EXISTS role;

CREATE TABLE role (
  id INT AUTO_INCREMENT PRIMARY KEY,
  role_title VARCHAR(30) NOT NULL,
  category ENUM('Performance', 'Production', 'Songwriting') NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  CONSTRAINT uq_role_title UNIQUE (role_title),
  CONSTRAINT chk_role_title_nonempty CHECK (role_title <> ''),
  INDEX idx_role_title (role_title)
);



-- Create release_credit_role
DROP TABLE IF EXISTS release_credit_role;

CREATE TABLE release_credit_role (
  id INT AUTO_INCREMENT PRIMARY KEY,
  release_credit_id INT NOT NULL,
  role_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  FOREIGN KEY (release_credit_id) REFERENCES release_credit(id),
  FOREIGN KEY (role_id) REFERENCES role(id),
  UNIQUE (release_credit_id, role_id)
);

-- Create table song
DROP TABLE IF EXISTS song;

CREATE TABLE song (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  duration INT NOT NULL,
  isrc VARCHAR(12) UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
-- constraints
  CONSTRAINT chk_song_title_nonempty CHECK (title <> ''),
  CONSTRAINT chk_song_duration_nonnegative CHECK (duration >= 0),
  INDEX idx_song_title (title)
);

-- Create relation table song_writer
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

SELECT
id,
first_name,
last_name
FROM person
ORDER BY id;

SELECT
id,
title
FROM song
ORDER BY id;

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

DROP TABLE IF EXISTS record_format;

CREATE TABLE record_format (
  id INT AUTO_INCREMENT PRIMARY KEY,
  format_type VARCHAR(20) NOT NULL,
  category ENUM('Physical', 'Special Edition', 'Digital') NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- constraints
  UNIQUE (format_type),
  CHECK (format_type <> '')
);

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
           