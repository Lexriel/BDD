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
