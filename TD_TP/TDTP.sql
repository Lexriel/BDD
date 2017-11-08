-- TP2 - EXERCICE 1 --
----------------------

-- postgresql en ligne de commande :
-- sudo -i -u postgres
-- psql

-- Il est important de supprimer d'abord les tables filles
-- ainsi que les types avant leurs apparitions
DROP table if exists catalogue cascade;
DROP type  if exists colors cascade;
DROP table if exists articles cascade;
DROP table if exists fournisseurs cascade;

-- Il manque la couleur rose (question 1.5)
CREATE TYPE colors as ENUM('rouge','noir','argente','opaque','cyan','magenta',
'vert','superjaune','rose');


-- Création des tables
-- Suite à l'ajout des contraintes de clés primaires, il faut que les lignes
-- des tables parentes soient insérées avant celles des tables filles (question
-- 1.1).
CREATE TABLE Articles(
aid int primary key,                     
anom varchar(30), 
acoul colors
);

-- On doit connaître l'adresse et le nom d'un fournisseur et on peut supposer
-- qu'ils doivent être uniques (question 1.2).
CREATE TABLE Fournisseurs(
fid int primary key,
fnom varchar(30) unique not NULL,
fad varchar(70) unique not NULL
);


-- On doit connaître le prix d'un article et celui-ci doit être non-nul.
-- Si un fournisseur ou un article est mis à jour ou disparaît, on fait
-- disparaître les lignes de même fid ou aid dans catalogue (question
-- 1.4). Les champs fid et aid sont des clés étrangères (question 1.3).
CREATE TABLE Catalogue(
fid int references Fournisseurs(fid) on update cascade on delete cascade,   
aid int references Articles(aid) on update cascade on delete cascade, 
prix numeric(8,2) not NULL check (prix >0),
primary key (fid,aid) 
);

-- Insertion des articles
INSERT INTO Articles VALUES (1,'Left Handed Toaster Cover','rouge');
INSERT INTO Articles VALUES (2,'Smoke Shifter End','noir');
INSERT INTO Articles VALUES (3,'Acme Widget Washer','rouge');
INSERT INTO Articles VALUES (4,'Acme Widget Washer','argente');
INSERT INTO Articles VALUES (5,'Brake for Crop Circles Sticker','opaque');
INSERT INTO Articles VALUES (6,'Anti-Gravity Turbine Generator','cyan');
INSERT INTO Articles VALUES (7,'Anti-Gravity Turbine Generator','magenta');
INSERT INTO Articles VALUES (8,'Fire Hydrant Cap','rouge');
INSERT INTO Articles VALUES (9,'7 Segment Display','vert');
INSERT INTO Articles VALUES (10,'Microsd Card USB Reader','vert');
INSERT INTO Articles VALUES (11,'Ferrari F430','rouge');
INSERT INTO Articles VALUES (12,'Microsd Card USB Reader','rouge');
INSERT INTO Articles VALUES (13,'Microsd Card USB Reader','rose');
INSERT INTO Articles VALUES (14,'Microsd Card USB Reader','vert');
INSERT INTO Articles VALUES (15,'Ferrari F430','vert');
INSERT INTO Articles VALUES (16,'Chewy Cake','rose');

-- Insertion des fournisseurs
INSERT INTO Fournisseurs VALUES (1,'kiventout','59 rue du Chti, F-75001 Paris');
INSERT INTO Fournisseurs VALUES (2,'Big Red Tool and Die','4 My Way, Bermuda Shorts, OR 90305, USA');
INSERT INTO Fournisseurs VALUES (3,'Perfunctory Parts','99999 Short Pier, Terra Del Fuego, TX 41299, USA');
INSERT INTO Fournisseurs VALUES (4,'Alien Aircaft Inc.','2 Groom Lake, Rachel, NV 51902, USA');
INSERT INTO Fournisseurs VALUES (5,'Autolux','Piazza del Paris, 8, I-20121 Milano');
INSERT INTO Fournisseurs VALUES(6,'HappyCake','De Ruijterkade 11, 1011 AA Amsterdam');

-- Insertion du catalogue, doit être réalisé après celles du fournisseurs
-- et des articles à cause des clés étrangères (question 1.5)
INSERT INTO Catalogue VALUES (1,1,36.10);
INSERT INTO Catalogue VALUES (1,2,42.30);
INSERT INTO Catalogue VALUES (1,3,15.30);
INSERT INTO Catalogue VALUES (1,4,20.50);
INSERT INTO Catalogue VALUES (1,5,20.50);
INSERT INTO Catalogue VALUES (1,6,124.23);
INSERT INTO Catalogue VALUES (1,7,124.23);
INSERT INTO Catalogue VALUES (1,8,11.70);
INSERT INTO Catalogue VALUES (1,9,75.20);
INSERT INTO Catalogue VALUES (2,1,16.50);
INSERT INTO Catalogue VALUES (2,7,0.55);
INSERT INTO Catalogue VALUES (2,8,7.95);
INSERT INTO Catalogue VALUES (3,8,12.50);
INSERT INTO Catalogue VALUES (3,9,1.00);
INSERT INTO Catalogue VALUES (4,4,57.3);
INSERT INTO Catalogue VALUES (4,5,22.20);
INSERT INTO Catalogue VALUES (4,8,48.6);
INSERT INTO Catalogue VALUES (5,11,234555.67);
INSERT INTO Catalogue VALUES (2,13,1.23);

-- Insertion du canard en plastique jaune (question 1.6)
INSERT INTO Articles VALUES (17,'Rubber Duck','superjaune');

-- Insertion d'un article dans le catalogue (question 1.7)
-- avec un prix valant max(prix) + 0.01
SELECT max(prix) FROM Catalogue; -- Donne 234555.67
INSERT INTO Catalogue VALUES (4,11,234555.67+0.01);

-- Insertion dans Articles violant une contrainte de clé primaire (question 1.8)
INSERT INTO Articles VALUES (3,'Balai Magique','noir');

-- Insertion d'un article de prix négatif (question 1.9)
-- La contrainte d'intégrité check empêche l'insertion de prix négatifs.
INSERT INTO Catalogue VALUES (1,11,-12.03);


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


-- TD2 - EXERCICE 1 --
----------------------

-- Domain     --    Max value           --
------------------------------------------
-- Decimal(10)      9999999999.0
-- Integer          4294967296     (2^32)   (non signé)
-- Decimal(9)        999999999.0
-- Numeric(12,4)      99999999.9999
-- Decimal(6,1)          99999.9
-- SmallInt              65536     (2^16)   (non signé)

-- Decimal(10) est équivalent à Decimal(10,0)
-- Numeric et Dicimal sont équivalents

-- TD2 - EXERCICE 2 --
----------------------

-- La norme écrit ceci :
-- CREATE DOMAIN STRING as character varying (256) default 'inconnu' not NULL;

-- Dans mySQL : pas de création de type !
-- Dans postGreSQL :
-- CREATE TYPE enregistre un nouveau type utilisable dans la base de données. 
-- CREATE DOMAIN enregistre un nouveau domaine à partir d'un type de données 
-- et des contraintes optionnelles.
-- On peut créer un domaine de cette façon sur postGreSQL
CREATE DOMAIN adresse as varchar(256) default 'inconnu' not NULL;
-- ENUM n'est pas un type. Mais on peut créer un type enum avec ENUM :
CREATE TYPE booleen as ENUM('vrai', 'faux');


-- TD2 - EXERCICE 3 --
----------------------

-- La table Author est la table parente de la table Book qui est sa table fille.
-- Tout auteur de la table Book doit exister dans la table Author à cause des clés
-- étrangères.
-- CREATE TABLE Author(
-- firstName   character(25),
-- surname     character(25),
-- dateOfBirth date,
-- nationality character(20),
-- primary key (firstName, surname)
-- );


-- CREATE TABLE Book(
-- bookTitle       character(30) primary key,
-- authorFirstName character(25),
-- authorSurname   character(25),
-- language        character(20),
-- foreign key (AuthorFirstName, AuthorSurname) references Author(firstName, surname)
--             on delete cascade on update set NULL
-- );


--       TD2        --
----------------------

-- Cette commande efface de la table Author chaque ligne dont l'attribut est 'Russel'.
-- Avec la politique de cascade, chaque ligne de Book dont l'attribut AuthorName='Russel'
-- est également effacé.
-- DELETE FROM Author WHERE surname='Russel';

-- Cette commande ne modifie aucune table et retourne une erreur si l'auteur 'Eco' est
-- dans la table Author, les clés étrangères refusent de perdre la référence à la table
-- Author. 
-- UPDATE Book SET authorFirstName='Umberto' WHERE authorSurname='Eco';


-- Cette commande ajoute un nouvel auteur dans la table Author s'il n'existe pas, cela
-- n'a aucun effet sur la table Book
-- INSERT into Author(firstName, surname) VALUES ('Isaac', 'Asimov');

-- Cette commande change le prénom de tous les auteurs dont surname='Zola' dans Author.
-- Chaque ligne dont authorSurname='Zola' et authorFirstName!='Emile' dans la table Book
-- aura des lignes NULL à la place de ces deux attributs.
-- UPDATE Author SET firstName='Emile' WHERE surname='Zola';


-- TD2 - EXERCICE 5 --
----------------------

-- On présente ici une astuce pour traiter parallèlement deux traitements
-- On sépare les employés de salaire<30000 en le divisant temporairement par 2
-- Cela garantira que la diminution suivante des salaires ne sera pas réhaussée ensuite :
-- UPDATE Employee SET Salary=Salary/2 WHERE Salary<=30000;
-- On diminue le salaire des employés au salaire>30000 :
-- UPDATE Employee SET Salary=Salary*0.95 WHERE Salary>30000;
-- On remet le salaire initial des employés au salaire<30000 et l'augmente de 10% :
-- UPDATE Employee SET Salary=Salary*2*1.1 WHERE Salary<=15000;


-- TD2 - EXERCICE 6 --
----------------------

-- Requêtes renvoyant pour chaque article le fid du fournisseur et son prix 
-- question 6.1 (avec un produit cartésien)
SELECT distinct fid, prix FROM articles, catalogue;
-- question 6.2 (avec une jointure naturelle)
SELECT distinct fid, prix FROM articles NATURAL JOIN catalogue;
-- question 6.3 (avec une jointure interne)
SELECT distinct fid, prix FROM articles a JOIN catalogue c on (a.aid=c.aid);
SELECT distinct fid, prix FROM articles JOIN catalogue using (aid);

-- Requêtes donnant les identifiants des articles non fournissables
-- question 6.4 (avec except)
SELECT distinct aid as identifiant FROM articles EXCEPT (SELECT aid FROM catalogue);
-- question 6.5 (avec une jointure externe)
SELECT distinct a.aid FROM articles a LEFT JOIN catalogue c on a.aid=c.aid WHERE prix is NULL;
SELECT distinct aid FROM articles LEFT JOIN catalogue using (aid) WHERE prix is NULL;

-- Requêtes donnant les noms des fournisseurs n'ayant pas d'articles à moins de 20€
-- question 6.6 (avec une jointure externe)
SELECT fnom FROM fournisseurs f LEFT JOIN (SELECT * FROM catalogue WHERE prix <20) as R
on f.fid=R.fid WHERE R.fid is NULL;

-- question 6.7 (avec un except)
(SELECT fnom FROM fournisseurs) EXCEPT
(SELECT fnom FROM fournisseurs NATURAL JOIN catalogue WHERE prix < 20);


--       TP3        --
----------------------


-- question 1
SELECT anom as ARTICLES, count(distinct acoul) as NB_COUL
FROM articles
GROUP BY anom;

-- question 2
SELECT anom as article, min(prix), max(prix), count(distinct fid) as nb_f
FROM articles NATURAL JOIN catalogue
GROUP BY anom
HAVING count(distinct fid)>1;

-- question 3
SELECT acoul as couleurs_rares FROM articles
GROUP BY acoul
HAVING count(acoul)=1;
-- ou HAVING count(*)=1

-- question 4
SELECT acoul as couleur, avg(prix) as prix_moyen
FROM articles NATURAL JOIN catalogue
WHERE anom not like '%Ferrari%'
GROUP BY acoul
HAVING count(aid)>1
ORDER BY prix_moyen desc;

-- question 5
SELECT aid, acoul, count(distinct fid) as nb_f
FROM articles NATURAL JOIN catalogue
GROUP BY aid, acoul;

-- question 6
SELECT anom as "ARTICLE", count(distinct fid) as "NB_F"
FROM articles LEFT JOIN catalogue using (aid)
GROUP BY anom;

-- question 7
SELECT fnom as "FOURNISSEURS", count(distinct anom) as "nbArticles"
FROM fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
GROUP BY fnom 
HAVING count(distinct (anom,acoul)) > 1;

-- question 8
SELECT fnom as fournisseur, anom as article
FROM fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
GROUP BY fnom, anom
HAVING count(distinct acoul)>1;

-- question 9
SELECT anom as article
FROM articles NATURAL JOIN catalogue
GROUP BY anom
HAVING count(distinct fid)=1;

-- question 10
SELECT lettre, count(lettre) as compteur FROM(
  SELECT substr(anom, 1, 1) as lettre FROM Articles 
  GROUP BY (anom)) as liste_lettres
GROUP BY lettre
ORDER BY lettre;

-- question 11
SELECT upper(lettres) as lettre, count(lettres) as compteur FROM(
  SELECT substring(CAST( acoul as text) from 1 for 1) as lettres
  FROM Articles GROUP BY aid) as liste_lettres
GROUP BY lettres
ORDER BY lettres;

-- question 12
SELECT * FROM articles JOIN catalogue ON articles.aid=catalogue.aid;
SELECT * FROM articles JOIN catalogue using(aid);
-- Contrairement à la jointure avec ON, la jointure avec using
-- regroupe les aid en une colonne comme le fait une jointure
-- naturelle.


-- TD3 - EXERCICE 1 --
----------------------

-- question 1
SELECT acoul, count(*) FROM articles GROUP BY acoul HAVING count(*)>2;

-- question 2
SELECT fnom, max(prix) FROM fournisseurs NATURAL JOIN catalogue GROUP BY fnom;

-- question 3 (faux, non standard)
-- anom devrait apparaître dans une clause GROUP BY
SELECT anom, max(prix) FROM catalogue NATURAL JOIN articles; -- ne fonctionne pas

-- question 3 (avec une sous-requête)
SELECT anom, prix FROM catalogue NATURAL JOIN articles
WHERE prix = (SELECT max(prix) FROM catalogue); -- = ou IN
-- Les fonctions d'aggrégat ne sont pas acceptés dans les clauses WHERE.

-- question 4
SELECT anom FROM catalogue NATURAL JOIN articles
GROUP BY anom HAVING avg(prix) > (SELECT avg(prix) FROM catalogue);
-- Cette requête donne le nom des articles fournissables du catalogue dont
-- le prix moyen est supérieur au prix moyen des articles du catalogue.
-- C'est le cas uniquement pour la Ferrari

-- question 5
SELECT aid FROM catalogue WHERE prix >= ALL (SELECT prix FROM catalogue);
-- Cette requête donne l'aid du fournisseur qui vend l'article le plus cher.


-- question 6
SELECT fnom FROM catalogue NATURAL JOIN fournisseurs
GROUP BY fid, fnom HAVING count(*) >= ALL (SELECT count(*) FROM catalogue GROUP BY fid);
-- Cette requête donne le nom du fournisseur ayant le plus grand choix
-- d'articles

-- question 6 (alternative)
SELECT fnom FROM catalogue NATURAL JOIN fournisseurs
GROUP BY fid, fnom
HAVING count(*) =
      (SELECT max(N.nb_articles) FROM (SELECT count(*) as nb_articles
       FROM catalogue GROUP BY fid) as N);


-- TD3 - EXERCICE 2 --
----------------------

-- question 1
SELECT upper(fnom) FROM fournisseurs;

-- question 2
-- || permet de concaténer des chaînes
SELECT anom || ', ' || acoul FROM articles ORDER BY articles;

-- question 3
SELECT substring(anom from 1 for 1) FROM articles;

-- question 4
SELECT substring(CAST(acoul as varchar(15)) from 1 for 1) FROM articles;

-- question 4 (avec une sous-requête)
SELECT substring(acoul from 1 for 1) FROM
(SELECT CAST (acoul AS varchar(10)) FROM articles) as R;
-- Une sous-requête doit avoir un alias (même inutilisé)


-- TD4 - EXERCICE 1 --
----------------------

-- Question 1:
SELECT aid
FROM articles a NATURAL JOIN catalogue c NATURAL JOIN fournisseurs f
WHERE f.fnom='kiventout' and 
f.fid<>SOME (SELECT fid FROM catalogue WHERE a.aid=c.aid);
--  aid 
-- -----
--    1
--    4
--    5
--    7
--    8
--    9
-- (6 rows)
-- La table du TD est affichée avec la requête suivante :
SELECT fid, aid, CAST(anom as varchar(10)) as anom, acoul, prix,
       CAST(fnom as varchar(10)) as fnom, CAST(fad as varchar(10)) as fad
FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs;

-- Question 2:
-- Cette requête donne les aid d'articles fournissables par kiventout
-- qui sont également proposés par d'autres vendeurs.

-- Question 3:
-- PROJECT[aid](SELECT[fnom='kiventout'](catalogue JOIN fournisseurs))
-- INTERSECT
-- PROJECT[aid](SELECT[fnom<>'kiventout'](catalogue JOIN fournisseurs))

-- Question 4:
SELECT c.aid FROM catalogue c, fournisseurs f
WHERE f.fnom='kiventout' and c.fid=f.fid and exists(
  SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and f.fid<>c2.fid
);

-- Question 5:
-- Cela correspondrait aux aid d'articles vendus exclusivement par
-- kiventout.
SELECT c.aid FROM catalogue c, fournisseurs f
WHERE f.fnom='kiventout' and c.fid=f.fid and not exists(
  SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and f.fid<>c2.fid
);

-- Question 6:
-- Le résultat serait vide car on aurait un bug logique: on
-- retrouverait le fid de kiventout dans la sous-requête.
SELECT aid
FROM articles a NATURAL JOIN catalogue c NATURAL JOIN fournisseurs f
WHERE f.fnom='kiventout' and 
f.fid<>ALL (SELECT fid FROM catalogue WHERE a.aid=c.aid);
-- On aurait, par exemple, 5 <> ALL {4,5,7} (impossible). Cela
-- implique résultat de sous-requête vide, donc résultat de la requête
-- principale vide.

-- Question 7:
-- On aurait les aid d'articles vendus exclusivement par quiventout
-- (comme question 5).
-- PROJECT[aid](SELECT[fnom='kiventout'](catalogue JOIN fournisseurs))
-- EXCEPT
-- PROJECT[aid](SELECT[fnom<>'kiventout'](catalogue JOIN fournisseurs))
-- Ce n'est pas trivial a voir et mérite un exemple au tableau (minus
-- de qqc pas contenu dans le premier ensemble).


--       TP4        --
----------------------

-- Question 1: couleurs rares (exists)
-- Sélectionner les couleurs dans a telle qu'il n'existe pas de ligne
-- dans a2 où pour la même couleur on ait un aid différent.
SELECT a.acoul as CouleursRares FROM articles a
WHERE not exists 
(SELECT * FROM articles a2 WHERE a.acoul=a2.acoul and a.aid<>a2.aid);

-- Question 2: article en rouge n'existant pas en vert (exists)
SELECT a.anom, a.aid FROM articles a WHERE a.acoul='rouge'
and not exists (SELECT * FROM articles a2 WHERE a2.anom = a.anom and a.acoul='vert');

-- Question 2: article en rouge n'existant pas en vert (not in)
SELECT aid, anom FROM articles WHERE acoul='rouge'
and anom not in (SELECT anom FROM articles WHERE  acoul='vert');

-- Question 2: article en rouge n'existant pas en vert (all)
SELECT aid, anom FROM articles WHERE acoul='rouge'
and anom <> ALL (SELECT anom FROM articles WHERE  acoul='vert');

-- Question 3: fournisseurs dont l'article le plus cher est rouge
-- (group)
SELECT fnom FROM(
  SELECT fnom, fid, max(prix) as prix
  FROM fournisseurs NATURAL JOIN catalogue
  GROUP BY fid
  ) as tmp NATURAL JOIN catalogue NATURAL JOIN articles
where acoul = 'rouge';

-- Question 3: fournisseurs dont l'article le plus cher est rouge
-- (sans group)
SELECT fnom FROM(
  (SELECT fid, prix FROM catalogue)
  EXCEPT
  (SELECT a.fid, a.prix FROM catalogue as a, catalogue as b
   WHERE a.fid = b.fid and a.prix < b.prix)
) as tmp NATURAL JOIN fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
WHERE acoul='rouge';

-- Question 4: articles offerts par au moins 2 fournisseurs (exists)
SELECT distinct c.aid FROM catalogue c
WHERE exists
(SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and c2.fid<>c.fid);

-- Question 4: articles offerts par au moins 2 fournisseurs (group)
SELECT aid FROM catalogue
GROUP BY aid HAVING count(*) > 1
order by aid;

-- Question 4: articles offerts par au moins 2 fournisseurs (some)
-- Sélection des aid du catalogue dont le fid est différent de l'un
-- des fid de la sous-requête donnant les fid de tous les articles au
-- même aid.
SELECT distinct c.aid FROM catalogue c
WHERE c.fid <>SOME (SELECT fid FROM catalogue c2 WHERE c2.aid=c.aid);


-- il faut enlever les articles 10, 11 et 12 du catalogue pour obtenir
-- un résultat dans la question suivante
DELETE FROM Articles WHERE aid>9;

-- Question 5: vendeur offrant tous les articles (exists)
SELECT distinct f.fnom as CeluiQuiVendTout FROM fournisseurs f
WHERE not exists(
  -- trouver article que vendeur avec identifiant c.fid ne vend pas
  SELECT * FROM articles a
  WHERE not exists(
    ---- determiner si l'article avec identifiant a.aid 
    ---- est vendu par le vendeur avec c.fid
    SELECT * FROM catalogue c WHERE c.fid=f.fid and c.aid = a.aid
  )
);

-- Question 5:  vendeur offrant tous les articles (group, count)
SELECT distinct fnom as CeluiQuiVendTout
FROM catalogue NATURAL JOIN fournisseurs
GROUP BY fnom HAVING count(*) = (SELECT count(*) FROM articles);

-- Ré-insertion des articles
INSERT INTO Articles VALUES (10,'Microsd Card USB Reader','vert');
INSERT INTO Articles VALUES (11,'Ferrari F430','rouge');
INSERT INTO Articles VALUES (12,'Microsd Card USB Reader','rouge');
INSERT INTO Articles VALUES (13,'Microsd Card USB Reader','rose');
INSERT INTO Articles VALUES (14,'Microsd Card USB Reader','vert');
INSERT INTO Articles VALUES (15,'Ferrari F430','vert');
INSERT INTO Articles VALUES (16,'Chewy Cake','rose');
INSERT INTO Articles VALUES (17,'Rubber Duck','superjaune');
INSERT INTO Catalogue VALUES (5,11,234555.67);
INSERT INTO Catalogue VALUES (2,13,1.23);


-- Requête non-demandée: articles exclusivement rouges (except)
(SELECT distinct anom FROM articles WHERE acoul='rouge') EXCEPT 
(SELECT distinct anom FROM articles WHERE acoul<>'rouge');

-- Requête non-demandée: articles exclusivement rouges (exists)
SELECT a.anom FROM articles a WHERE a.acoul='rouge' 
and not exists(
  SELECT * FROM articles a2 WHERE a2.anom=a.anom and a2.acoul<>'rouge'
);

-- Requête non-demandée: articles exclusivement rouges (not in)
SELECT a.anom FROM articles a WHERE a.acoul='rouge' 
and a.anom not in(
  SELECT a2.anom FROM articles a2 WHERE a2.anom=a.anom and a2.acoul<>'rouge'
);

-- Question 6: vendeur de l'article le plus cher (sous-requête)
SELECT distinct fnom FROM catalogue NATURAL JOIN fournisseurs
where prix=(SELECT max(prix) FROM catalogue);

-- Question 6: vendeur de l'article le plus cher (exists)
SELECT fnom FROM catalogue c1 NATURAL JOIN fournisseurs
WHERE not exists(
  SELECT * FROM catalogue c2 WHERE c2.prix>c1.prix
);

-- Question 6: vendeur de l'article le plus cher (all)
SELECT fnom FROM catalogue NATURAL JOIN fournisseurs
WHERE prix>=ALL (SELECT prix FROM catalogue);

-- Question 7: nom des articles fournissables avec prix maximal et
-- minimal, uniquement pour les articles avec plus d'un vendeur
-- (group)
SELECT anom, min(prix), max(prix) FROM articles NATURAL JOIN catalogue 
GROUP BY anom HAVING count(distinct fid)>1;

-- Question 7: nom des articles fournissables avec prix maximal et
-- minimal, uniquement pour les articles avec plus d'un vendeur
-- (exists)
SELECT  a.anom,  min(prix), max(prix) FROM articles a NATURAL JOIN catalogue c
WHERE exists (SELECT * FROM catalogue c2 WHERE c2.aid=a.aid and c2.fid<>c.fid)
GROUP BY a.anom;

-- Question 8: fournisseur qui vend le meme article en plus d'une
-- couleur, et le nom de l'article concerné (group)
SELECT  fnom, anom FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs
GROUP BY fid, fnom, anom HAVING count (distinct acoul) > 1;

-- Question 8: fournisseur qui vend le meme article en plus d'une
-- couleur, et le nom de l'article concerné (exists)
SELECT distinct f.fnom, a.anom
FROM articles a NATURAL JOIN catalogue c NATURAL JOIN fournisseurs f
WHERE exists(
  SELECT * FROM articles a2 NATURAL JOIN catalogue c2
  WHERE a2.anom = a.anom and c2.fid=f.fid and a2.acoul<>a.acoul
);

-- Question 8: fournisseur qui vend le meme article en plus d'une
-- couleur, et le nom de l'article concerné (some)
SELECT distinct fnom, anom FROM fournisseurs NATURAL JOIN catalogue c NATURAL JOIN articles a
WHERE anom = SOME(
    SELECT a2.anom FROM catalogue c2 NATURAL JOIN articles a2
    WHERE a2.acoul <> a.acoul and c2.fid=c.fid
);

-- Pour la question suivante:
-- >= ALL n'a été vu en cours que pour la clause WHERE. 
-- Le prédicat fonctionne de la même façon pour la clause HAVING.

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (group)
SELECT fid, fnom, count(*) FROM catalogue NATURAL JOIN fournisseurs
GROUP BY fid, fnom
HAVING count(*)>=ALL (SELECT count(*) FROM catalogue GROUP BY fid);

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (group - sans fid)
SELECT max(R.nb_articles) FROM(
  SELECT count(*) as nb_articles, fid FROM catalogue GROUP BY fid
) as R;

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (group)
SELECT fid, count(aid) FROM catalogue
GROUP BY fid
HAVING count(aid) = max(aid);

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (view)
CREATE VIEW choix_par_fournisseur(fid, nbarticles)
as
SELECT fid, count (*) FROM catalogue GROUP BY fid;
SELECT fid, nbarticles FROM choix_par_fournisseur
WHERE nbarticles = (SELECT max(nbarticles) FROM ChoixParFournisseur);

-- Question 10: articles offerts par un seul vendeur, toutes couleurs
-- confondues (group)
SELECT anom FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs
GROUP BY anom HAVING count(distinct fnom)=1;

-- Question 10: articles offerts par un seul vendeur, toutes couleurs
-- confondues (exists)
SELECT a.anom FROM articles a NATURAL JOIN catalogue c
WHERE not exists(
  SELECT * FROM catalogue c2 NATURAL JOIN articles a2 
  WHERE c2.fid<>c.fid and a2.anom=a.anom
);

-- Question 11: vendeur sans articles (in)
SELECT fid, fnom FROM fournisseurs WHERE fid not in 
(SELECT fid FROM catalogue);

-- Question 11: vendeur sans articles (all)
SELECT fid, fnom FROM fournisseurs 
WHERE fid<>ALL (SELECT fid FROM catalogue);

-- Question 11: vendeur sans articles (exists)
SELECT fid, fnom FROM fournisseurs f
WHERE not exists (SELECT * FROM catalogue c WHERE c.fid=f.fid);

-- Question 12: articles coutant au moins 100 euros, chez tous les
-- vendeurs (exists)
SELECT distinct c.aid FROM catalogue c
WHERE c.prix >= 100 and not exists
(SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and c2.prix<100);

-- Question 12: articles coutant au moins 100 euros, chez tous les
-- vendeurs (all)
SELECT distinct aid FROM catalogue c WHERE prix >= 100 
GROUP BY c.aid
HAVING 100 > ALL (SELECT prix FROM catalogue c2 WHERE c2.aid=c.aid);

-- Question 12: articles coutant au moins 100 euros, chez tous les
-- vendeurs (min)
SELECT distinct aid FROM catalogue c WHERE prix >= 100 
GROUP BY c.aid
HAVING 100 > ALL (SELECT prix FROM catalogue c2 WHERE c2.aid=c.aid);

-- Question 13: articles disponibles aux Etats-Unis uniquement
-- (exists)
SELECT distinct aid FROM catalogue c NATURAL JOIN fournisseurs f
WHERE fad like '%USA%' and not exists(
  SELECT * FROM catalogue c2 NATURAL JOIN fournisseurs f2
  WHERE c.aid=c2.aid and f2.fad not like '%USA%'
);


--       TP5        --
----------------------

-- Création des tables de la base de données aérienne

DROP TABLE if exists certifications cascade;
DROP TABLE if exists avions cascade;
DROP TABLE if exists employes cascade;
DROP TABLE if exists vols cascade;

CREATE TABLE avions(
aid int primary key,
anom varchar(30),
portee int);

INSERT INTO avions VALUES(1,'Boeing 747-400',8430);
INSERT INTO avions VALUES(2,'Boeing 737-800',3383);
INSERT INTO avions VALUES(3,'Airbus A340-300',7120);
INSERT INTO avions VALUES(4,'British Aerospace Jetstream 41',1502);
INSERT INTO avions VALUES(5,'Embraer ERJ-145',1530);
INSERT INTO avions VALUES(6,'SAAB 340',2128);
INSERT INTO avions VALUES(7,'Piper Archer III',520);
INSERT INTO avions VALUES(8,'Tupolev 154',4103);
INSERT INTO avions VALUES(16,'Schwitzer 2-33',30);
INSERT INTO avions VALUES(9,'Lockheed L1011',6900);
INSERT INTO avions VALUES(10,'Boeing 757-300',4010);
INSERT INTO avions VALUES(11,'Boeing 777-300',6441);
INSERT INTO avions VALUES(12,'Boeing 767-400ER',6475);
INSERT INTO avions VALUES(13,'Airbus A320',2605);
INSERT INTO avions VALUES(14,'Airbus A319',1805);
INSERT INTO avions VALUES(15,'Boeing 727',1504);
-- INSERT INTO avions VALUES(16,'Airbus A380-800ER',18001);

create table employes(
eid int primary key,
enom varchar(30),
salaire int
);

INSERT INTO employes VALUES(242518965,'Ivonne Boulala',120433);
INSERT INTO employes VALUES(141582651,'Anael Klein',178345);
INSERT INTO employes VALUES(011564812,'Joris Robillard',153972);
INSERT INTO employes VALUES(567354612,'Laura Giacco',256481);
INSERT INTO employes VALUES(552455318,'Patricia Jones',101745);
INSERT INTO employes VALUES(550156548,'Victor Goron',205187);
INSERT INTO employes VALUES(390487451,'Linda Mariencourt',212156);
INSERT INTO employes VALUES(274878974,'Valentin Owczarek',289950);
INSERT INTO employes VALUES(254099823,'Brahim Akouz',24450);
INSERT INTO employes VALUES(356187925,'Astelia Massamba',44740);
INSERT INTO employes VALUES(355548984,'Hugo Ermenidis',212156 );
INSERT INTO employes VALUES(310454876,'Boubacar Diallo',212156);
INSERT INTO employes VALUES(489456522,'Justin Dutoit',27984);
INSERT INTO employes VALUES(489221823,'Nadir Trabelsi',23980);
INSERT INTO employes VALUES(548977562,'Ulysses Boulala',84476);
INSERT INTO employes VALUES(310454877,'Ceyhun Ozugur',33546);
INSERT INTO employes VALUES(142519864,'Teresa Klatzer',227489);
INSERT INTO employes VALUES(269734834,'Ana Bozianu',99890);
INSERT INTO employes VALUES(287321212,'Mengmeng Zhao',48090);
INSERT INTO employes VALUES(552455348,'Rachid El Amrani',152013);
INSERT INTO employes VALUES(248965255,'Perrine Honore',43723);
INSERT INTO employes VALUES(159542516,'Maxence Gens',48250);
INSERT INTO employes VALUES(348121549,'Catalin Daniel Ramirez',32899);
INSERT INTO employes VALUES(090873519,'Hakim Taleb',32021);
INSERT INTO employes VALUES(486512566,'Simon Jeunechamp',43001);
INSERT INTO employes VALUES(619023588,'Jennifer Thomas',54921);
INSERT INTO employes VALUES(015645489,'Camille Girard',18050);
INSERT INTO employes VALUES(556784565,'Etienne Renard',205187);
INSERT INTO employes VALUES(573284895,'Tommy Carpentier',114323);
INSERT INTO employes VALUES(574489456,'Nicolas Baudin',105743);
INSERT INTO employes VALUES(574489457,'Oussama Moulana',20);

create table certifications(
eid int references employees(eid),
aid int references avions(aid),
primary key (eid,aid)
);

INSERT INTO certifications VALUES(567354612,1);
INSERT INTO certifications VALUES(567354612,2);
INSERT INTO certifications VALUES(567354612,10);
INSERT INTO certifications VALUES(567354612,11);
INSERT INTO certifications VALUES(567354612,12);
INSERT INTO certifications VALUES(567354612,15);
INSERT INTO certifications VALUES(567354612,7);
INSERT INTO certifications VALUES(567354612,9);
INSERT INTO certifications VALUES(567354612,3);
INSERT INTO certifications VALUES(567354612,4);
INSERT INTO certifications VALUES(567354612,5);
INSERT INTO certifications VALUES(552455318,2);
INSERT INTO certifications VALUES(552455318,14);
INSERT INTO certifications VALUES(550156548,1);
INSERT INTO certifications VALUES(550156548,12);
INSERT INTO certifications VALUES(390487451,3);
INSERT INTO certifications VALUES(390487451,13);
INSERT INTO certifications VALUES(390487451,14);
INSERT INTO certifications VALUES(274878974,10);
INSERT INTO certifications VALUES(274878974,12);
INSERT INTO certifications VALUES(355548984,8);
INSERT INTO certifications VALUES(355548984,9);
INSERT INTO certifications VALUES(310454876,8);
INSERT INTO certifications VALUES(310454876,9);
INSERT INTO certifications VALUES(548977562,7);
INSERT INTO certifications VALUES(142519864,1);
INSERT INTO certifications VALUES(142519864,11);
INSERT INTO certifications VALUES(142519864,12);
INSERT INTO certifications VALUES(142519864,10);
INSERT INTO certifications VALUES(142519864,3);
INSERT INTO certifications VALUES(142519864,2);
INSERT INTO certifications VALUES(142519864,13);
INSERT INTO certifications VALUES(142519864,7);
INSERT INTO certifications VALUES(269734834,1);
INSERT INTO certifications VALUES(269734834,2);
INSERT INTO certifications VALUES(269734834,3);
INSERT INTO certifications VALUES(269734834,4);
INSERT INTO certifications VALUES(269734834,5);
INSERT INTO certifications VALUES(269734834,6);
INSERT INTO certifications VALUES(269734834,7);
INSERT INTO certifications VALUES(269734834,8);
INSERT INTO certifications VALUES(269734834,9);
INSERT INTO certifications VALUES(269734834,10);
INSERT INTO certifications VALUES(269734834,11);
INSERT INTO certifications VALUES(269734834,12);
INSERT INTO certifications VALUES(269734834,13);
INSERT INTO certifications VALUES(269734834,14);
INSERT INTO certifications VALUES(269734834,15);
INSERT INTO certifications VALUES(552455318,7);
INSERT INTO certifications VALUES(556784565,5);
INSERT INTO certifications VALUES(556784565,2);
INSERT INTO certifications VALUES(556784565,3);
INSERT INTO certifications VALUES(573284895,3);
INSERT INTO certifications VALUES(573284895,4);
INSERT INTO certifications VALUES(573284895,5);
INSERT INTO certifications VALUES(574489456,8);
INSERT INTO certifications VALUES(574489456,6);
INSERT INTO certifications VALUES(574489457,7);
INSERT INTO certifications VALUES(242518965,2);
INSERT INTO certifications VALUES(242518965,10);
INSERT INTO certifications VALUES(141582651,2);
INSERT INTO certifications VALUES(141582651,10);
INSERT INTO certifications VALUES(141582651,12);
INSERT INTO certifications VALUES(011564812,2);
INSERT INTO certifications VALUES(011564812,10);
INSERT INTO certifications VALUES(356187925,6);
INSERT INTO certifications VALUES(159542516,5);
INSERT INTO certifications VALUES(159542516,7);
INSERT INTO certifications VALUES(090873519,6);

create table vols(
vid int,
dep varchar(30),
arr varchar(30),
distance int,
h_dep timestamp,
h_arr timestamp,
prix real
);

INSERT INTO vols VALUES(99,'Los Angeles','Washington D.C.',2308,'2011-04-12 09:30','2011-04-12 21:40',235.98);
INSERT INTO vols VALUES(13,'Los Angeles','Chicago',1749,'2011-04-12 08:45','2011-04-12 20:45',220.98);
INSERT INTO vols VALUES(346,'Los Angeles','Dallas',1251,'2011-04-12 11:50','2011-04-12 19:05',225.43);
INSERT INTO vols VALUES(387,'Los Angeles','Boston',2606,'2011-04-12 07:03','2011-04-12 17:03',261.56);
INSERT INTO vols VALUES(7,'Los Angeles','Sydney',7487,'2011-04-12 22:30','2011-04-14 6:10',1278.56);
INSERT INTO vols VALUES(2,'Los Angeles','Tokyo',5478,'2011-04-12 12:30','2011-04-13 15:55',780.99);
INSERT INTO vols VALUES(33,'CDG','NOU',17000,'2011-04-12 09:15','2011-04-14 11:15',3750.23);
INSERT INTO vols VALUES(34,'CDG','NOU',17000,'2011-04-12 12:45','2011-04-14 15:18',4250.98);
INSERT INTO vols VALUES(76,'Chicago','Los Angeles',1749,'2011-04-12 08:32','2011-04-12 10:03',220.98);
INSERT INTO vols VALUES(68,'Chicago','New York',802,'2011-04-12 09:00','2011-04-12 12:02',202.45);
INSERT INTO vols VALUES(7789,'Madison','Detroit',319,'2011-04-12 06:15','2011-04-12 08:19',120.33);
INSERT INTO vols VALUES(701,'Detroit','New York',470,'2011-04-12 08:55','2011-04-12 10:26',180.56);
INSERT INTO vols VALUES(702,'Madison','New York',789,'2011-04-12 07:05','2011-04-12 10:12',202.34);
INSERT INTO vols VALUES(4884,'Madison','Chicago',84,'2011-04-12 22:12','2011-04-12 23:02',112.45);
INSERT INTO vols VALUES(2223,'Madison','Pittsburgh',517,'2011-04-12 08:02','2011-04-12 10:01',189.98);
INSERT INTO vols VALUES(5694,'Madison','Minneapolis',247,'2011-04-12 08:32','2011-04-12 09:33',120.11);
INSERT INTO vols VALUES(304,'Minneapolis','New York',991,'2011-04-12 10:00','2011-04-12 1:39',101.56);
INSERT INTO vols VALUES(149,'Pittsburgh','New York',303,'2011-04-12 09:42','2011-04-12 12:09',116.50);


--       TP5        --
----------------------

-- Question 1
-- Pour chaque pilote certifié pour au moins deux avions, donnez l'eid
-- et la portée maximale d’avion pour lesquels ce pilote est certifié.
SELECT eid, max(portee) FROM certifications NATURAL JOIN avions
GROUP BY eid
HAVING	count(*) >= 2;


-- Question 2
-- Déterminez les noms de pilotes dont le salaire est inférieur au
-- prix du vol le moins cher de l'aéroport Charles de Gaulle (CDG)
-- vers l'aéroport La Tontouta en Nouvelle Calédonie (NOU).
SELECT distinct enom FROM employes WHERE
salaire < (SELECT min(prix) FROM vols WHERE dep='CDG' AND arr='NOU');
-- ou bien
SELECT enom, eid FROM employes WHERE
salaire < ALL(SELECT prix FROM vols WHERE dep='CDG' and arr='NOU');


-- Question 3
-- Quelles routes (départ et destination) peuvent être volées par
-- tous les pilotes gagnant plus de 100 000 euros ?
SELECT dep, arr, distance FROM vols WHERE
distance <= ALL(
  SELECT max(portee) FROM
  employes NATURAL JOIN certifications NATURAL JOIN avions
  WHERE salaire>=100000
  GROUP BY eid)
ORDER BY distance;

-- Question 4
-- Affichez les noms des pilotes qui sont uniquement certifiés pour
-- des avions avec une portée supérieure à 1500km.
SELECT enom FROM employes NATURAL JOIN certifications NATURAL JOIN avions 
GROUP BY eid, enom
HAVING EVERY (portee > 1500)
ORDER BY enom;

-- Question 5
-- Affichez les noms des pilotes qui sont uniquement certifiés pour
-- des avions avec une portée supérieure à 1500km, pour au moins
-- deux tels avions.
SELECT enom FROM employes NATURAL JOIN certifications NATURAL JOIN avions 
GROUP BY eid, enom
HAVING EVERY (portee > 1500) and count(*)>1
ORDER BY enom;

-- Question 6
-- Donnez les noms des pilotes qui sont certifiés uniquement pour
-- des avions d'une portée supérieure à 1500km, et qui sont certifiés
-- pour au moins un type de Boeing.
SELECT enom FROM employes NATURAL JOIN certifications NATURAL JOIN avions 
GROUP BY eid, enom
HAVING EVERY (portee > 1500) and count(*)>1 and bool_or(anom like 'Boeing%')
ORDER BY enom;

-- Question 7
-- Trouvez l'identifiant de l'employé avec le deuxième salaire le plus
-- élevé.
SELECT enom, eid, salaire FROM employes WHERE 
salaire= (SELECT max(salaire) FROM employes WHERE 
          salaire<>(SELECT max(salaire) FROM employes));

-- Question 8
-- Affichez les noms des pilotes qui peuvent piloter des avions d’une
-- portée supérieure à 2000km, mais qui ne sont certifiés pour aucun
-- Boeing.
SELECT * FROM employes e WHERE 
  e.eid in (SELECT eid FROM certifications NATURAL JOIN avions 
	    WHERE portee>2000)
  and
  e.eid not in (SELECT eid FROM certifications NATURAL JOIN avions
                WHERE anom like 'Boeing%')
ORDER BY e.eid;
-- ou bien
SELECT * FROM employes e
WHERE EXISTS (SELECT * FROM certifications c NATURAL JOIN avions
	      WHERE portee>2000 and c.eid=e.eid)
and not EXISTS (SELECT * FROM certifications c NATURAL JOIN avions
                WHERE anom like 'Boeing%' and c.eid=e.eid);

-- Question 9
-- Affichez les noms et revenus d'employés qui ne sont pas des pilotes,
-- mais qui gagnent plus que le revenu moyen des pilotes.
SELECT e.enom, e.salaire FROM employes e WHERE
e.eid not in (SELECT eid FROM certifications)
and
e.salaire > (SELECT avg(salaire) FROM employes WHERE
             eid in (SELECT distinct eid FROM certifications));

-- Question
-- Affichez les noms et revenus des pilotes gagnant plus que le revenu
-- moyen des pilotes.
SELECT e.enom, e.salaire FROM employes e WHERE
e.eid in (SELECT eid FROM certifications)
and
e.salaire > (SELECT avg(salaire) FROM employes WHERE
             eid in (SELECT distinct eid FROM certifications));

-- Question 10
-- Calculez la différence entre le revenu moyen de pilotes, et le revenu
-- moyen de tous les employés (pilotes inclus).
-- Attention : les pilotes ayant plusieurs avions, leurs salaires peuvent
-- apparaître plusieurs fois, il ne faut les compter qu'une fois.
SELECT RevPilotes.avg - RevEmployes.avg as difference FROM
  (SELECT avg(salaire) AS avg FROM employes WHERE
   eid in (SELECT distinct eid FROM certifications))
  as RevPilotes,
  (SELECT avg(salaire) as avg FROM employes) as RevEmployes;

-- Question 11
-- Est-il possible de prendre une séquence de vols de La Tantouta à
-- Timbuktu ? Chaque vol de la séquence doit partir de la ville qui est
-- l'arrivée du vol précédent. Le premier vol doit partir de La Tantouta,
-- et le dernier vol doit arriver à Timbuktu. Il n'y a aucune contrainte
-- sur le nombre de vols intermédiaires. Votre requête doit être capable
-- de déterminer si il existe une séquence allant de La Tantouta à Timbuktu,
-- pour n'importe quelle instance de la relation vols.
WITH RECURSIVE trajet(dep, arr) AS (
  (SELECT dep, arr FROM vols)
  UNION
  (SELECT t.dep, v.arr FROM trajet t, vols v WHERE t.arr=v.dep)
)
SELECT * FROM trajet WHERE dep='Madison' and arr='Dallas';


--       TD5        --
----------------------

-- Question:
-- Afficher les noms, eid et salaires des pilotes ayant le salaire
-- le plus élevé à l'aide d'une vue.
CREATE VIEW SalairePilotes(eid, pilote, salaire) as 
SELECT eid, enom, salaire FROM employes NATURAL JOIN certifications;
SELECT distinct eid, pilote, salaire FROM SalairePilotes WHERE
salaire>=ALL(SELECT salaire FROM SalairePilotes);

-- Question:
-- Afficher les noms, eid et nombres de certifications des pilotes
-- ayant le plus de certifications à l'aide d'une vue.
CREATE VIEW CertifPilotes(eid, pilote, nb) as 
SELECT eid, enom, count(*) FROM employes NATURAL JOIN certifications
GROUP BY eid, enom;
SELECT * FROM CertifPilotes WHERE
nb=(SELECT max(nb) FROM CertifPilotes);

-- Question:
-- Afficher les infos des vols les moins chers entre CDG et NOU à
-- l'aide d'une vue.
CREATE VIEW Vols_CDG_NOU as 
SELECT * FROM Vols WHERE dep='CDG' and arr='NOU';
SELECT * FROM Vols_CDG_NOU WHERE
prix=(SELECT min(prix) FROM Vols_CDG_NOU);
