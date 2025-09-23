-- Insert release_credit
SET NAMES utf8mb4;
-- (safe, idempotent)
USE rimfrost_db;
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