-- TP2 - EXERCICE 1 --
----------------------

SELECT * FROM Articles;
-- 
--  aid |              anom              |   acoul    
-- -----+--------------------------------+------------
--    1 | Left Handed Toaster Cover      | rouge
--    2 | Smoke Shifter End              | noir
--    3 | Acme Widget Washer             | rouge
--    4 | Acme Widget Washer             | argente
--    5 | Brake for Crop Circles Sticker | opaque
--    6 | Anti-Gravity Turbine Generator | cyan
--    7 | Anti-Gravity Turbine Generator | magenta
--    8 | Fire Hydrant Cap               | rouge
--    9 | 7 Segment Display              | vert
--   10 | Microsd Card USB Reader        | vert
--   11 | Ferrari F430                   | rouge
--   12 | Microsd Card USB Reader        | rouge
--   13 | Microsd Card USB Reader        | rose
--   14 | Microsd Card USB Reader        | vert
--   15 | Ferrari F430                   | vert
--   16 | Chewy Cake                     | rose
--   17 | Rubber Duck                    | superjaune
-- (17 rows)

SELECT * FROM Catalogue;
-- 
--  fid | aid |   prix    
-- -----+-----+-----------
--    1 |   1 |     36.10
--    1 |   2 |     42.30
--    1 |   3 |     15.30
--    1 |   4 |     20.50
--    1 |   5 |     20.50
--    1 |   6 |    124.23
--    1 |   7 |    124.23
--    1 |   8 |     11.70
--    1 |   9 |     75.20
--    2 |   1 |     16.50
--    2 |   7 |      0.55
--    2 |   8 |      7.95
--    3 |   8 |     12.50
--    3 |   9 |      1.00
--    4 |   4 |     57.30
--    4 |   5 |     22.20
--    4 |   8 |     48.60
--    5 |  11 | 234555.67
--    2 |  13 |      1.23
--    4 |  11 | 234555.68
-- (20 rows)

SELECT * FROM Fournisseurs;
-- 
--  fid |         fnom         |                       fad                        
-- -----+----------------------+--------------------------------------------------
--    1 | kiventout            | 59 rue du Chti, F-75001 Paris
--    2 | Big Red Tool and Die | 4 My Way, Bermuda Shorts, OR 90305, USA
--    3 | Perfunctory Parts    | 99999 Short Pier, Terra Del Fuego, TX 41299, USA
--    4 | Alien Aircaft Inc.   | 2 Groom Lake, Rachel, NV 51902, USA
--    5 | Autolux              | Piazza del Paris, 8, I-20121 Milano
--    6 | HappyCake            | De Ruijterkade 11, 1011 AA Amsterdam
-- (6 rows)


-- Suppression créant un orphelin (question 1.10)
DELETE FROM Articles WHERE aid=13;
-- Cette suppression crée un orphelin dans le catalogue, l'effet cascade
-- supprime la ligne du catalogue où aid=13.

-- Ajout des lignes supprimées par la commande précédente
INSERT INTO Articles VALUES (13,'Microsd Card USB Reader','rose');
INSERT INTO Catalogue VALUES (2,13,1.23);

-- TP2 - EXERCICE 2 --
----------------------

-- question 2.1 (avec renommage d'une colonne)
SELECT fnom as fournisseur FROM fournisseurs;

-- question 2.2 (avec motif dans fad)
SELECT fnom FROM fournisseurs WHERE fad like '%75%Paris';

-- question 2.3 (avec jointure naturelle)
SELECT distinct fnom FROM catalogue NATURAL JOIN fournisseurs WHERE prix < 20;

-- question 2.4 (avec un booléen)
SELECT distinct fid FROM catalogue WHERE prix >= 10 and prix <= 20;

-- question 2.4 (avec between)
SELECT distinct fid FROM catalogue WHERE prix between 10 and 20;

-- question 2.4 (avec un intersect)
(SELECT fid FROM catalogue WHERE prix >= 10)
INTERSECT
(SELECT fid FROM catalogue WHERE prix <= 20);

-- question 2.5
SELECT anom,acoul,prix FROM articles NATURAL JOIN catalogue
WHERE (acoul= 'vert' or acoul='rouge') and prix <20;

-- question 2.6 (avec une jointure naturelle)
SELECT anom FROM articles NATURAL JOIN catalogue;

-- question 2.6 (avec une jointure externe et renommage de tables)
SELECT anom FROM articles a JOIN catalogue c on a.aid=c.aid;
SELECT anom FROM articles a JOIN catalogue c using (aid);

-- question 2.6 (avec un produit cartésien)
SELECT anom FROM articles a, catalogue c WHERE a.aid=c.aid;

-- question 2.7 (avec des jointures naturelles)
SELECT distinct fnom FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs WHERE acoul='rouge';

-- question 2.8 (avec un except)
(SELECT fnom FROM fournisseurs)
EXCEPT
(SELECT fnom, fad FROM fournisseurs NATURAL JOIN catalogue
 WHERE prix < 10000);

-- question 2.8 (avec des in/not in)
SELECT fnom, fad FROM fournisseurs
WHERE fid     in (SELECT fid FROM catalogue WHERE prix >= 10000)
      and
      fid not in (SELECT fid FROM catalogue WHERE prix < 10000);

-- question 2.8 (avec des in/not exists)
SELECT  fnom, fad FROM fournisseurs f
WHERE f.fid in (SELECT fid FROM catalogue WHERE prix >= 10000)
      and
      not exists (SELECT * FROM catalogue c WHERE c.fid = f.fid and prix < 10000);

-- question 2.9 (a1.acoul like 'vert' ne fonctionne pas pour le type enum)
SELECT a1.anom, a2.anom FROM articles a1, articles a2
WHERE a1.acoul='vert' and a2.acoul='rouge';

-- question 2.10 (avec un full join)
SELECT a.anom,a.aid FROM articles a FULL JOIN catalogue c on a.aid=c.aid
WHERE fid is NULL;
SELECT anom,aid FROM articles FULL JOIN catalogue using (aid)
WHERE fid is NULL;

-- question 2.10 (avec un not in)
SELECT anom,aid FROM articles WHERE aid not in (SELECT aid FROM catalogue);

-- question 2.11 (avec un intersect)
(SELECT fid FROM catalogue NATURAL JOIN articles WHERE acoul='vert')
INTERSECT
(SELECT fid FROM catalogue NATURAL JOIN articles WHERE acoul='rouge');

-- question 2.12 (avec un except)
(SELECT fnom FROM fournisseurs)
EXCEPT
(SELECT fnom FROM fournisseurs NATURAL JOIN articles NATURAL JOIN catalogue WHERE acoul='noir' or acoul='argente');

-- question 2.12 (avec un not in)
SELECT fnom FROM fournisseurs WHERE fid not in 
(SELECT fid FROM catalogue NATURAL JOIN articles
 WHERE acoul='noir' or acoul='argente');

