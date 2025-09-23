-- insert songwriters
SET NAMES utf8mb4;
-- (safe, idempotent)
USE rimfrost_db;
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