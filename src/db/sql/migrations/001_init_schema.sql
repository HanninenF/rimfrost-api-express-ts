
-- Create database
CREATE DATABASE IF NOT EXISTS rimfrost_db
DEFAULT CHARACTER SET utf8mb4;

-- Use database
USE rimfrost_db;

-- Create person
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

-- Create record
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

-- Create record_format
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

-- Create release_credit (FK: person, record)
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

-- Create release_credit_role (FK: release_credit, role)
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

-- Create table song_writer (FK: person, song)
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

-- Create song_writer_roles (FK: song_writer, role)
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

--Create track_list (FK: record, song)
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

-- Create edition (FK: record, record_format)
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