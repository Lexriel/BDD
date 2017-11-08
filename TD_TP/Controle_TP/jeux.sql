-- Exercice 1 --
----------------

-- Question 1
DROP table if exists Jeux_joues;
DROP table if exists Donnees_joueurs;

CREATE TABLE Donnees_joueurs(
id int primary key,
nom varchar(30) not NULL,
adresse varchar(30) not NULL
);

CREATE TABLE Jeux_joues(
id int references Donnees_joueurs(id) on update cascade on delete cascade,
jeu varchar(30),
primary key (jeu,id)
);

-- Question 2
INSERT INTO Donnees_joueurs VALUES (1, 'joueur1', 'Lille');
INSERT INTO Donnees_joueurs VALUES (2, 'joueur2', 'Lens');
INSERT INTO Donnees_joueurs VALUES (3, 'joueur3', 'Lille');
INSERT INTO Donnees_joueurs VALUES (4, 'joueur4', 'Lille');

INSERT INTO Jeux_joues VALUES (1, 'War');
INSERT INTO Jeux_joues VALUES (1, 'Racing');
INSERT INTO Jeux_joues VALUES (2, 'Foot');
INSERT INTO Jeux_joues VALUES (2, 'Advendture');
INSERT INTO Jeux_joues VALUES (3, 'Advendture');
INSERT INTO Jeux_joues VALUES (3, 'Racing');
INSERT INTO Jeux_joues VALUES (3, 'War');
INSERT INTO Jeux_joues VALUES (4, 'War');
INSERT INTO Jeux_joues VALUES (4, 'Advendture');

SELECT * FROM Donnees_joueurs NATURAL JOIN Jeux_joues;

-- Question 3
UPDATE Donnees_joueurs SET adresse='Dunkerque' WHERE nom='joueur4';
UPDATE Donnees_joueurs SET adresse='Loos' WHERE nom='joueur2';

-- Question 4
CREATE temp VIEW Nb_jeux as
  (SELECT nom, id, count(*) as nb
   FROM Donnees_joueurs NATURAL JOIN Jeux_joues
   GROUP BY id, nom);
SELECT nom FROM Nb_jeux WHERE nb=(SELECT max(nb) FROM Nb_jeux);
SELECT id FROM Nb_jeux WHERE nb=(SELECT max(nb) FROM Nb_jeux);
-- DROP VIEW Nb_jeux;

-- Question 5
SELECT jeu, nom FROM Donnees_joueurs NATURAL JOIN Jeux_joues
WHERE jeu in (
  SELECT jeu FROM Jeux_joues
  GROUP BY jeu
  HAVING count(*)=1
);
