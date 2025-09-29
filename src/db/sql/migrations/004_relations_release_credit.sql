-- Insert release_credit
SET NAMES utf8mb4;
-- (safe, idempotent)
USE rimfrost_db;
INSERT INTO release_credit (person_id, release_id) VALUES
/*person_id 1= Hänninen*/
(1,1), /* Unredeemed Demons */
(1,2), /* A Frozen World Unknown */
(1,3), /* Veraldar Nagli */
(1,4), /* Rimfrost    */
/*person_id 2= Svedlund*/
(2,1), /* Unredeemed Demons */
(2,2), /* A Frozen World Unknown */
(2,3), /* Veraldar Nagli */
(2,4), /* Rimfrost    */
/*person_id 5= Lettenström*/
(5,4),  
/*person_id 6= Mikael*/
(6,4),
/*person_id 7= Kjellgren*/
(7,2),
/*person_id 8= Viktor*/
(8,3),
/*person_id 9= Peter*/
(9,3),
/*person_id 10= Påhlsson*/
(10,2),
/*person_id 11= Andreas*/
(11,2),
/*person_id 12= Sandström*/
(12,2), /* A Frozen World Unknown */
(12,3), /* Veraldar Nagli */
(12,4), /* Rimfrost    */
/*person_id 13= Ricardo*/
(13,4),
/*person_id 14= Istvan*/
(14,4),
/*person_id 15= Anders*/
(15,3),
/*person_id 16= Karlsson*/
(16,1),
/*person_id 17= Gullberg*/
(17,1),
/*person_id 18= Joakim*/
(18,1);

-- Insert release_credit_role

START TRANSACTION;

-- ===== HÄNNINEN =====
/* SET @pid = 1; */

DELETE rcr
FROM release_credit_role AS rcr
JOIN release_credit AS rc ON rc.id = rcr.release_credit_id
JOIN person AS p ON p.id = rc.person_id
WHERE p.id = 1;

INSERT IGNORE INTO release_credit_role (release_credit_id, role_id)
SELECT rc.id, pr.role_id
FROM (
  SELECT 1 AS record_id, 5 AS role_id   /* Drums */
  UNION ALL SELECT 1, 3                 /* Guitars */
  -- A Frozen
  UNION ALL SELECT 2, 5                 /* Drums */
  UNION ALL SELECT 2, 2                 /* Backing Vocals */
  -- Veraldar
  UNION ALL SELECT 3, 5                 /* Drums */
  UNION ALL SELECT 3, 2                 /* Backing Vocals */
  UNION ALL SELECT 3, 6                 /* Keys */
  UNION ALL SELECT 3, 7                 /* Producer */
  -- Rimfrost
  UNION ALL SELECT 4, 5                 /* Drums */
  UNION ALL SELECT 4, 2                 /* Backing Vocals */
  UNION ALL SELECT 4, 1                 /* Vocals */
  UNION ALL SELECT 4, 6                 /* Keys */
  UNION ALL SELECT 4, 7                 /* Producer */
  UNION ALL SELECT 4, 10                /* Recording Engineer */
) AS pr           -- 🔴 alias krävs
JOIN release_credit AS rc
  ON rc.person_id = 1
 AND rc.release_id = pr.record_id;


-- ===== SVEDLUND =====
/* SET @pid := 2; */

-- Rensa befintliga kopplingar
DELETE rcr
FROM release_credit_role AS rcr
JOIN release_credit AS rc ON rc.id = rcr.release_credit_id
WHERE rc.person_id = 2;

INSERT IGNORE INTO release_credit_role (release_credit_id, role_id)
SELECT rc.id, pr.role_id
FROM (
  SELECT 1 AS record_id, 1 AS role_id   /* Vocals */
  UNION ALL SELECT 1,3                  /* Guitars */
  -- A Frozen
  UNION ALL SELECT 2, 1                 /* Vocals */
  UNION ALL SELECT 2, 3                 /* Guitars */
  UNION ALL SELECT 2, 2                 /* Backing Vocals */
  -- Veraldar
  UNION ALL SELECT 3, 1                 /* Vocals */
  UNION ALL SELECT 3, 3                 /* Guitars */
  UNION ALL SELECT 3, 2                 /* Backing Vocals */
  UNION ALL SELECT 3, 6                 /* Keys */
  UNION ALL SELECT 3, 7                 /* Producer */
  -- Rimfrost
  UNION ALL SELECT 4, 1                 /* Vocals */
  UNION ALL SELECT 4, 3                 /* Guitars */
  UNION ALL SELECT 4, 2                 /* Backing Vocals */
  UNION ALL SELECT 4, 7                 /* Producer */
  UNION ALL SELECT 4, 14                /* Photography */
) AS pr           -- 🔴 alias krävs
JOIN release_credit AS rc
  ON rc.person_id = 2
 AND rc.release_id = pr.record_id;


-- ===== Övriga DIREKTA (release_credit_id, role_id) =====

DELETE rcr
FROM release_credit_role AS rcr
JOIN release_credit AS rc ON rc.id = rcr.release_credit_id
WHERE rc.person_id IN (3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18);

-- OBS: här är första värdet release_credit_id (inte record_id)
INSERT IGNORE INTO release_credit_role (release_credit_id, role_id) VALUES
-- Sandström A Frozen / Veraldar / Rimfrost
(16,14),
(17,14),
(18,14),
-- Karlsson Unredeemed
(22,4),
-- Gullberg Unredeemed
(23,11),
(23,13),
-- Ericsson Unredeemed
(24,14),
-- Kjellgren A Frozen
(11,8),
(11,9),
(11,6),
(11,2),
(11,7),
(11,10),
-- Påhlsson A Frozen
(14,4),
(14,2),
-- Åsfeldt A Frozen
(15,11),
(15,13),
-- Viktor Veraldar
(12,11),
(12,13),
-- Peter Veraldar
(13,4),
(13,10),
-- Andy Veraldar
(21,7),
(21,8),
(21,9),
-- Lettenström Rimfrost
(9,4),
(9,2),
(9,7),
-- Micke Rimfrost
(10,8),
(10,9),
(10,10),
-- Ricardo Rimfrost
(19,13),
-- Istvan Rimfrost
(20,12);

COMMIT;














