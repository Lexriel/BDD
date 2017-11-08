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
