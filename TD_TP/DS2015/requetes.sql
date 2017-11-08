-- Question 1.1
-- Niveau d'études le plus fréquent par âges
CREATE temp VIEW stat(age, niveau, nb) AS
SELECT age, niveau, count(*) FROM etudiants
GROUP BY age, niveau;

SELECT age, niveau FROM stat s
WHERE nb=(SELECT max(nb) FROM stat s2 WHERE s2.niveau=s.niveau);


-- Question 1.2
-- Nom de l'étudiant le plus jeune suivant un cours de I.Boulala le mercredi
CREATE temp VIEW etud(eid, enom, age) AS(
  SELECT e_id, e_nom, age
  FROM etudiants NATURAL JOIN participer
  NATURAL JOIN cours NATURAL JOIN profs	    
  WHERE prof_nom='I.Boulala' and horaire like '%Me%'
);

SELECT enom FROM etud WHERE age<=ALL(SELECT age FROM etud);


-- Question 1.3
-- Noms de profs qui enseignent dans l'ensemble des salles où ont lieu des cours
SELECT prof_nom FROM profs p
WHERE not EXISTS(
  SELECT * FROM cours c1 WHERE not EXISTS(
    SELECT * FROM cours c2 
    WHERE c1.salle<>c2.salle and c2.prof_id=p.prof_id
  )
);


-- Question 1.4
-- Prof et nombre total de cours enseigné par les profs ne donnant cours que
-- dans la salle R128
SELECT prof_nom, count(*) FROM profs p1 NATURAL JOIN cours
WHERE salle='R128' and not EXISTS(
  SELECT * FROM profs p2 NATURAL JOIN cours WHERE
  p1.prof_id=p2.prof_id and salle<>'R128'
)
GROUP BY prof_id, prof_nom
HAVING EVERY(salle='R128');


-- Question supprimée du DS
-- CREATE temp VIEW pr_ens_nb(prof_nom,titre,nb)
-- as 
-- SELECT prof_nom, titre, count(*) as nb
-- FROM profs NATURAL JOIN cours NATURAL JOIN participer
-- GROUP BY prof_id, prof_nom, titre;

-- SELECT prof_nom, titre
-- FROM pr_ens_nb as p
-- WHERE nb>=ALL(SELECT nb FROM pr_ens_nb);

-- SELECT prof_nom, titre FROM pr_ens_nb 
-- WHERE nb=(SELECT max(nb) FROM pr_ens_nb);

