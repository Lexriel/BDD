--       TP8        --
----------------------

-- Requête 1 - noms et prix des machines produites par l'atelier
SELECT nom_machine, prix FROM Machines;

-- Requête 2 - noms et villes des fournisseurs de roues
SELECT fournisseur, ville FROM P_fournisseurs NATURAL JOIN Pieces WHERE nom_piece='roue';

-- Requête 3 - nom des pièces composant la presse et leur nombre
SELECT nom_piece, qte_piece FROM
Machines NATURAL JOIN Composition_machines NATURAL JOIN Pieces
WHERE nom_machine='Presse';

-- Requête 4 - nombre de pièces pour une presse
SELECT sum(qte_piece) as nb_pieces_presse
FROM Machines NATURAL JOIN Composition_machines NATURAL JOIN Pieces
WHERE nom_machine='Presse';

-- Requête 5 - nom des pièces contenues à la fois dans la presse et la moissonneuse-batteuse
SELECT nom_piece FROM Pieces WHERE
  id_piece IN(SELECT id_piece FROM Composition_machines NATURAL JOIN Machines
              WHERE nom_machine='Presse')
  and
  id_piece IN(SELECT id_piece FROM Composition_machines NATURAL JOIN Machines
              WHERE nom_machine='Moissonneuse-batteuse');

-- Requête 5 - autre requête possible
SELECT nom_piece FROM Pieces WHERE id_piece IN (
  (SELECT id_piece FROM Composition_machines NATURAL JOIN Machines
   WHERE nom_machine='Presse')
  INTERSECT
  (SELECT id_piece FROM Composition_machines NATURAL JOIN Machines
   WHERE nom_machine='Moissonneuse-batteuse')
);

-- Requête 6 - pièces de la moissonneuse-batteuse, leur quantités,
-- villes et fournisseurs
SELECT nom_piece, qte_piece, f.fournisseur as fournisseur, ville 
FROM Machines NATURAL JOIN Composition_machines NATURAL JOIN
     Pieces p LEFT JOIN P_fournisseurs f
     ON p.id_fournisseur=f.id_fournisseur
WHERE nom_machine='Moissonneuse-batteuse';

-- Requête 7 - noms de machines et quantités à livrer jusqu'au 30 avril 2016
SELECT nom_machine, sum(quantite) FROM Commandes NATURAL JOIN Machines
WHERE date_livraison<='2016-04-30'
GROUP BY id_machine, nom_machine;

