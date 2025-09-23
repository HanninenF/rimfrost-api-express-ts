-- grunddata

SET NAMES utf8mb4;
-- (safe, idempotent)
USE rimfrost_db;
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
