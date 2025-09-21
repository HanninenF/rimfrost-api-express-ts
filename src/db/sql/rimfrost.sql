
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