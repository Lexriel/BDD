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

