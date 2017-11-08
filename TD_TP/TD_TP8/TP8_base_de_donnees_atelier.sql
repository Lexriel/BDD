--       TP8        --
----------------------

-- Création des tables de la base de données de l'atelier de
-- construction de machines agricoles

DROP TABLE if exists Composition_machines cascade;
DROP TABLE if exists Commandes, Pieces cascade;
DROP TABLE if exists P_fournisseurs, Machines cascade;

CREATE TABLE Machines(
id_machine int not NULL primary key,
nom_machine varchar(30) not NULL,
prix numeric(10,2) not NULL check (prix>0),
description text
);

CREATE TABLE P_fournisseurs(
id_fournisseur int not NULL primary key,
fournisseur varchar(30) not NULL,
adresse varchar(50),
ville varchar(20),
telephone numeric(10,0) unique not NULL,
fax numeric(10,0) unique not NULL
);

CREATE TABLE Commandes(
id_commande int not NULL primary key,
quantite int not NULL,
client varchar(30) not NULL,
date_livraison date not NULL,
id_machine int not NULL references Machines(id_machine)
  on update cascade on delete cascade
);

CREATE TABLE Pieces(
id_piece int not NULL primary key,
nom_piece varchar(30) not NULL,
en_stock int not NULL check
  ((en_stock=0 and id_fournisseur is not NULL) or (en_stock<>0 and id_fournisseur is NULL)),
id_fournisseur int references P_fournisseurs(id_fournisseur)
on update cascade on delete cascade
);

CREATE TABLE Composition_machines(
id_machine int not NULL references Machines(id_machine)
  on update cascade on delete cascade,
id_piece int references Pieces(id_piece)
  on update cascade on delete cascade,
qte_piece int not NULL check (qte_piece>0),
primary key (id_machine, id_piece)
);


INSERT INTO Machines VALUES(1, 'Presse', 35000, NULL);
INSERT INTO Machines VALUES(2, 'Moissonneuse-batteuse', 50000, NULL);

INSERT INTO P_fournisseurs VALUES(101, 'Recharges agricoles', '2, rue Bleue', 'Boulogne', 0320500001, 0320500002);
INSERT INTO P_fournisseurs VALUES(102, 'Multi Roues', '5, rue Jaune', 'Tourcoing', 0348000401, 0348000402);
INSERT INTO P_fournisseurs VALUES(105, 'Pouce Vert', '17, rue Noire', 'Lille', 0359806001, 0359806002);

INSERT INTO Commandes VALUES(17, 15, 'Mécanicien Lucien', '2016-03-15', 1);
INSERT INTO Commandes VALUES(22, 1, 'Gremise', '2016-05-20', 2);
INSERT INTO Commandes VALUES(23, 50, 'Saponnier', '2016-03-30', 1);
INSERT INTO Commandes VALUES(53, 10, 'Chicorée', '2016-04-30', 1);
INSERT INTO Commandes VALUES(51, 30, 'Chicorée', '2016-04-30', 2);

INSERT INTO Pieces VALUES(1, 'arbre', 0, 101);
INSERT INTO Pieces VALUES(2, 'deroulement', 0, 102);
INSERT INTO Pieces VALUES(3, 'embrayage', 0, 101);
INSERT INTO Pieces VALUES(4, 'roue', 0, 102);
INSERT INTO Pieces VALUES(5, 'structure primaire', 100, NULL);
INSERT INTO Pieces VALUES(6, 'van', 100, NULL);
INSERT INTO Pieces VALUES(7, 'batteur', 100, NULL);
INSERT INTO Pieces VALUES(8, 'ascenseur', 0, 105);
INSERT INTO Pieces VALUES(9, 'fiche', 0, 101);
INSERT INTO Pieces VALUES(10, 'tuyau', 0, 105);

INSERT INTO Composition_machines VALUES(1, 1, 1);
INSERT INTO Composition_machines VALUES(1, 2, 10);
INSERT INTO Composition_machines VALUES(1, 3, 4);
INSERT INTO Composition_machines VALUES(1, 4, 4);
INSERT INTO Composition_machines VALUES(2, 4, 4);
INSERT INTO Composition_machines VALUES(1, 5, 1);
INSERT INTO Composition_machines VALUES(2, 5, 1);
INSERT INTO Composition_machines VALUES(2, 6, 1);
INSERT INTO Composition_machines VALUES(2, 7, 1);
INSERT INTO Composition_machines VALUES(2, 8, 1);

