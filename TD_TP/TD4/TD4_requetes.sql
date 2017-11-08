-- TD4 - EXERCICE 1 --
----------------------

-- Question 1:
SELECT aid
FROM articles a NATURAL JOIN catalogue c NATURAL JOIN fournisseurs f
WHERE f.fnom='kiventout' and 
f.fid<>SOME (SELECT fid FROM catalogue WHERE a.aid=c.aid);
--  aid 
-- -----
--    1
--    4
--    5
--    7
--    8
--    9
-- (6 rows)
-- La table du TD est affichée avec la requête suivante :
SELECT fid, aid, CAST(anom as varchar(10)) as anom, acoul, prix,
       CAST(fnom as varchar(10)) as fnom, CAST(fad as varchar(10)) as fad
FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs;

-- Question 2:
-- Cette requête donne les aid d'articles fournissables par kiventout
-- qui sont également proposés par d'autres vendeurs.

-- Question 3:
-- PROJECT[aid](SELECT[fnom='kiventout'](catalogue JOIN fournisseurs))
-- INTERSECT
-- PROJECT[aid](SELECT[fnom<>'kiventout'](catalogue JOIN fournisseurs))

-- Question 4:
SELECT c.aid FROM catalogue c, fournisseurs f
WHERE f.fnom='kiventout' and c.fid=f.fid and exists(
  SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and f.fid<>c2.fid
);

-- Question 5:
-- Cela correspondrait aux aid d'articles vendus exclusivement par
-- kiventout.
SELECT c.aid FROM catalogue c, fournisseurs f
WHERE f.fnom='kiventout' and c.fid=f.fid and not exists(
  SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and f.fid<>c2.fid
);

-- Question 6:
-- Le résultat serait vide car on aurait un bug logique: on
-- retrouverait le fid de kiventout dans la sous-requête.
SELECT aid
FROM articles a NATURAL JOIN catalogue c NATURAL JOIN fournisseurs f
WHERE f.fnom='kiventout' and 
f.fid<>ALL (SELECT fid FROM catalogue WHERE a.aid=c.aid);
-- On aurait, par exemple, 5 <> ALL {4,5,7} (impossible). Cela
-- implique résultat de sous-requête vide, donc résultat de la requête
-- principale vide.

-- Question 7:
-- On aurait les aid d'articles vendus exclusivement par quiventout
-- (comme question 5).
-- PROJECT[aid](SELECT[fnom='kiventout'](catalogue JOIN fournisseurs))
-- EXCEPT
-- PROJECT[aid](SELECT[fnom<>'kiventout'](catalogue JOIN fournisseurs))
-- Ce n'est pas trivial a voir et mérite un exemple au tableau (minus
-- de qqc pas contenu dans le premier ensemble).
