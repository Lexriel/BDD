-- Exercice 1 --
----------------

-- Question 1
DROP table if exists Livres_lus;
DROP table if exists Donnees_lecteurs;

CREATE TABLE Donnees_lecteurs(
id int primary key,
nom varchar(30) not NULL,
categorie varchar(30) not NULL
);

CREATE TABLE Livres_lus(
id int references Donnees_lecteurs(id) on update cascade on delete cascade,
livre varchar(30),
primary key (livre,id)
);

-- Question 2
INSERT INTO Donnees_lecteurs VALUES (1, 'lecteurA', 'enfant');
INSERT INTO Donnees_lecteurs VALUES (2, 'lecteurB', 'ado');
INSERT INTO Donnees_lecteurs VALUES (3, 'lecteurC', 'adulte');
INSERT INTO Donnees_lecteurs VALUES (4, 'lecteurD', 'senior');

INSERT INTO Livres_lus VALUES (1, 'Contes de fées');
INSERT INTO Livres_lus VALUES (1, 'Amour d enfer');
INSERT INTO Livres_lus VALUES (2, 'Les roses');
INSERT INTO Livres_lus VALUES (2, 'Solitude');
INSERT INTO Livres_lus VALUES (3, 'Solitude');
INSERT INTO Livres_lus VALUES (3, 'Amour d enfer');
INSERT INTO Livres_lus VALUES (3, 'Contes de fées');
INSERT INTO Livres_lus VALUES (4, 'Contes de fées');
INSERT INTO Livres_lus VALUES (4, 'Solitude');

SELECT * FROM Donnees_lecteurs NATURAL JOIN Livres_lus;

-- Question 3
UPDATE Donnees_lecteurs SET categorie='senior' WHERE nom='lecteurC';

-- Question 4
CREATE temp VIEW Nb_livres as
  (SELECT nom, id, count(*) as nb
   FROM Donnees_lecteurs NATURAL JOIN Livres_lus
   GROUP BY id, nom);
SELECT nom FROM Nb_livres WHERE nb=(SELECT max(nb) FROM Nb_livres);
SELECT id FROM Nb_livres WHERE nb=(SELECT max(nb) FROM Nb_livres);
-- DROP VIEW Nb_livres;

-- Question 5
SELECT livre, nom FROM Donnees_lecteurs NATURAL JOIN Livres_lus
WHERE livre in (
  SELECT livre FROM Livres_lus
  GROUP BY livre
  HAVING count(*)=1
);
