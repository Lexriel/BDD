--       TP4        --
----------------------

-- Question 1: couleurs rares (exists)
-- Sélectionner les couleurs dans a telle qu'il n'existe pas de ligne
-- dans a2 où pour la même couleur on ait un aid différent.
SELECT a.acoul as CouleursRares FROM articles a
WHERE not exists 
(SELECT * FROM articles a2 WHERE a.acoul=a2.acoul and a.aid<>a2.aid);

-- Question 2: article en rouge n'existant pas en vert (exists)
SELECT a.anom, a.aid FROM articles a WHERE a.acoul='rouge'
and not exists (SELECT * FROM articles a2 WHERE a2.anom = a.anom and a2.acoul='vert');

-- Question 2: article en rouge n'existant pas en vert (not in)
SELECT aid, anom FROM articles WHERE acoul='rouge'
and anom not in (SELECT anom FROM articles WHERE  acoul='vert');

-- Question 2: article en rouge n'existant pas en vert (all)
SELECT aid, anom FROM articles WHERE acoul='rouge'
and anom <> ALL (SELECT anom FROM articles WHERE  acoul='vert');

-- Question 3: fournisseurs dont l'article le plus cher est rouge
-- (group)
SELECT fnom FROM(
  SELECT fnom, fid, max(prix) as prix
  FROM fournisseurs NATURAL JOIN catalogue
  GROUP BY fid
  ) as tmp NATURAL JOIN catalogue NATURAL JOIN articles
where acoul = 'rouge';

-- Question 3: fournisseurs dont l'article le plus cher est rouge
-- (sans group)
SELECT fnom FROM(
  (SELECT fid, prix FROM catalogue)
  EXCEPT
  (SELECT a.fid, a.prix FROM catalogue as a, catalogue as b
   WHERE a.fid = b.fid and a.prix < b.prix)
) as tmp NATURAL JOIN fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
WHERE acoul='rouge';

-- Question 4: articles offerts par au moins 2 fournisseurs (exists)
SELECT distinct c.aid FROM catalogue c
WHERE exists
(SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and c2.fid<>c.fid);

-- Question 4: articles offerts par au moins 2 fournisseurs (group)
SELECT aid FROM catalogue
GROUP BY aid HAVING count(*) > 1
order by aid;

-- Question 4: articles offerts par au moins 2 fournisseurs (some)
-- Sélection des aid du catalogue dont le fid est différent de l'un
-- des fid de la sous-requête donnant les fid de tous les articles au
-- même aid.
SELECT distinct c.aid FROM catalogue c
WHERE c.fid <>SOME (SELECT fid FROM catalogue c2 WHERE c2.aid=c.aid);


-- il faut enlever les articles 10, 11 et 12 du catalogue pour obtenir
-- un résultat dans la question suivante
DELETE FROM Articles WHERE aid>9;

-- Question 5: vendeur offrant tous les articles (exists)
SELECT distinct f.fnom as CeluiQuiVendTout FROM fournisseurs f
WHERE not exists(
  -- trouver article que vendeur avec identifiant c.fid ne vend pas
  SELECT * FROM articles a
  WHERE not exists(
    ---- determiner si l'article avec identifiant a.aid 
    ---- est vendu par le vendeur avec c.fid
    SELECT * FROM catalogue c WHERE c.fid=f.fid and c.aid = a.aid
  )
);

-- Question 5:  vendeur offrant tous les articles (group, count)
SELECT distinct fnom as CeluiQuiVendTout
FROM catalogue NATURAL JOIN fournisseurs
GROUP BY fnom HAVING count(*) = (SELECT count(*) FROM articles);

-- Ré-insertion des articles
INSERT INTO Articles VALUES (10,'Microsd Card USB Reader','vert');
INSERT INTO Articles VALUES (11,'Ferrari F430','rouge');
INSERT INTO Articles VALUES (12,'Microsd Card USB Reader','rouge');
INSERT INTO Articles VALUES (13,'Microsd Card USB Reader','rose');
INSERT INTO Articles VALUES (14,'Microsd Card USB Reader','vert');
INSERT INTO Articles VALUES (15,'Ferrari F430','vert');
INSERT INTO Articles VALUES (16,'Chewy Cake','rose');
INSERT INTO Articles VALUES (17,'Rubber Duck','superjaune');
INSERT INTO Catalogue VALUES (5,11,234555.67);
INSERT INTO Catalogue VALUES (2,13,1.23);


-- Requête non-demandée: articles exclusivement rouges (except)
(SELECT distinct anom FROM articles WHERE acoul='rouge') EXCEPT 
(SELECT distinct anom FROM articles WHERE acoul<>'rouge');

-- Requête non-demandée: articles exclusivement rouges (exists)
SELECT a.anom FROM articles a WHERE a.acoul='rouge' 
and not exists(
  SELECT * FROM articles a2 WHERE a2.anom=a.anom and a2.acoul<>'rouge'
);

-- Requête non-demandée: articles exclusivement rouges (not in)
SELECT a.anom FROM articles a WHERE a.acoul='rouge' 
and a.anom not in(
  SELECT a2.anom FROM articles a2 WHERE a2.anom=a.anom and a2.acoul<>'rouge'
);

-- Question 6: vendeur de l'article le plus cher (sous-requête)
SELECT distinct fnom FROM catalogue NATURAL JOIN fournisseurs
where prix=(SELECT max(prix) FROM catalogue);

-- Question 6: vendeur de l'article le plus cher (exists)
SELECT fnom FROM catalogue c1 NATURAL JOIN fournisseurs
WHERE not exists(
  SELECT * FROM catalogue c2 WHERE c2.prix>c1.prix
);

-- Question 6: vendeur de l'article le plus cher (all)
SELECT fnom FROM catalogue NATURAL JOIN fournisseurs
WHERE prix>=ALL (SELECT prix FROM catalogue);

-- Question 7: nom des articles fournissables avec prix maximal et
-- minimal, uniquement pour les articles avec plus d'un vendeur
-- (group)
SELECT anom, min(prix), max(prix) FROM articles NATURAL JOIN catalogue 
GROUP BY anom HAVING count(distinct fid)>1;

-- Question 7: nom des articles fournissables avec prix maximal et
-- minimal, uniquement pour les articles avec plus d'un vendeur
-- (exists)
SELECT  a.anom,  min(prix), max(prix) FROM articles a NATURAL JOIN catalogue c
WHERE exists (SELECT * FROM catalogue c2 WHERE c2.aid=a.aid and c2.fid<>c.fid)
GROUP BY a.anom;

-- Question 8: fournisseur qui vend le meme article en plus d'une
-- couleur, et le nom de l'article concerné (group)
SELECT  fnom, anom FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs
GROUP BY fid, fnom, anom HAVING count (distinct acoul) > 1;

-- Question 8: fournisseur qui vend le meme article en plus d'une
-- couleur, et le nom de l'article concerné (exists)
SELECT distinct f.fnom, a.anom
FROM articles a NATURAL JOIN catalogue c NATURAL JOIN fournisseurs f
WHERE exists(
  SELECT * FROM articles a2 NATURAL JOIN catalogue c2
  WHERE a2.anom = a.anom and c2.fid=f.fid and a2.acoul<>a.acoul
);

-- Question 8: fournisseur qui vend le meme article en plus d'une
-- couleur, et le nom de l'article concerné (some)
SELECT distinct fnom, anom FROM fournisseurs NATURAL JOIN catalogue c NATURAL JOIN articles a
WHERE anom = SOME(
    SELECT a2.anom FROM catalogue c2 NATURAL JOIN articles a2
    WHERE a2.acoul <> a.acoul and c2.fid=c.fid
);

-- Pour la question suivante:
-- >= ALL n'a été vu en cours que pour la clause WHERE. 
-- Le prédicat fonctionne de la même façon pour la clause HAVING.

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (group)
SELECT fid, fnom, count(*) FROM catalogue NATURAL JOIN fournisseurs
GROUP BY fid, fnom
HAVING count(*)>=ALL (SELECT count(*) FROM catalogue GROUP BY fid);

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (group - sans fid)
SELECT max(R.nb_articles) FROM(
  SELECT count(*) as nb_articles, fid FROM catalogue GROUP BY fid
) as R;

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (group)
SELECT fid, count(aid) FROM catalogue
GROUP BY fid
HAVING count(aid) = max(aid);

-- Question 9: nombre d'articles offerts par le vendeur avec le plus
-- grand choix, et le nom de ce fournisseur (view)
CREATE VIEW choix_par_fournisseur(fid, nbarticles)
as
SELECT fid, count (*) FROM catalogue GROUP BY fid;
SELECT fid, nbarticles FROM choix_par_fournisseur
WHERE nbarticles = (SELECT max(nbarticles) FROM ChoixParFournisseur);

-- Question 10: articles offerts par un seul vendeur, toutes couleurs
-- confondues (group)
SELECT anom FROM articles NATURAL JOIN catalogue NATURAL JOIN fournisseurs
GROUP BY anom HAVING count(distinct fnom)=1;

-- Question 10: articles offerts par un seul vendeur, toutes couleurs
-- confondues (exists)
SELECT a.anom FROM articles a NATURAL JOIN catalogue c
WHERE not exists(
  SELECT * FROM catalogue c2 NATURAL JOIN articles a2 
  WHERE c2.fid<>c.fid and a2.anom=a.anom
);

-- Question 11: vendeur sans articles (in)
SELECT fid, fnom FROM fournisseurs WHERE fid not in 
(SELECT fid FROM catalogue);

-- Question 11: vendeur sans articles (all)
SELECT fid, fnom FROM fournisseurs 
WHERE fid<>ALL (SELECT fid FROM catalogue);

-- Question 11: vendeur sans articles (exists)
SELECT fid, fnom FROM fournisseurs f
WHERE not exists (SELECT * FROM catalogue c WHERE c.fid=f.fid);

-- Question 12: articles coutant au moins 100 euros, chez tous les
-- vendeurs (exists)
SELECT distinct c.aid FROM catalogue c
WHERE c.prix >= 100 and not exists
(SELECT * FROM catalogue c2 WHERE c2.aid=c.aid and c2.prix<100);

-- Question 12: articles coutant au moins 100 euros, chez tous les
-- vendeurs (all)
SELECT distinct aid FROM catalogue c WHERE prix >= 100 
GROUP BY c.aid
HAVING 100 > ALL (SELECT prix FROM catalogue c2 WHERE c2.aid=c.aid);

-- Question 12: articles coutant au moins 100 euros, chez tous les
-- vendeurs (min)
SELECT distinct aid FROM catalogue c WHERE prix >= 100 
GROUP BY c.aid
HAVING 100 > ALL (SELECT prix FROM catalogue c2 WHERE c2.aid=c.aid);

-- Question 13: articles disponibles aux Etats-Unis uniquement
-- (exists)
SELECT distinct aid FROM catalogue c NATURAL JOIN fournisseurs f
WHERE fad like '%USA%' and not exists(
  SELECT * FROM catalogue c2 NATURAL JOIN fournisseurs f2
  WHERE c.aid=c2.aid and f2.fad not like '%USA%'
);
