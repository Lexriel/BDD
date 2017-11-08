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
