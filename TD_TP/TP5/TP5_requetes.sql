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
