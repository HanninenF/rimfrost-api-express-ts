-- lexikon”/enum-liknande)

SET NAMES utf8mb4;
-- (safe, idempotent)
USE rimfrost_db;
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
    