--       TP3        --
----------------------


-- question 1
SELECT anom as ARTICLES, count(distinct acoul) as NB_COUL
FROM articles
GROUP BY anom;

-- question 2
SELECT anom as article, min(prix), max(prix), count(distinct fid) as nb_f
FROM articles NATURAL JOIN catalogue
GROUP BY anom
HAVING count(distinct fid)>1;

-- question 3
SELECT acoul as couleurs_rares FROM articles
GROUP BY acoul
HAVING count(acoul)=1;
-- ou HAVING count(*)=1

-- question 4
SELECT acoul as couleur, avg(prix) as prix_moyen
FROM articles NATURAL JOIN catalogue
WHERE anom not like '%Ferrari%'
GROUP BY acoul
HAVING count(aid)>1
ORDER BY prix_moyen desc;

-- question 5
SELECT aid, acoul, count(distinct fid) as nb_f
FROM articles NATURAL JOIN catalogue
GROUP BY aid, acoul;

-- question 6
SELECT anom as "ARTICLE", count(distinct fid) as "NB_F"
FROM articles LEFT JOIN catalogue using (aid)
GROUP BY anom;

-- question 7
SELECT fnom as "FOURNISSEURS", count(distinct anom) as "nbArticles"
FROM fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
GROUP BY fnom 
HAVING count(distinct (anom,acoul)) > 1;

-- question 8
SELECT fnom as fournisseur, anom as article
FROM fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
GROUP BY fnom, anom
HAVING count(distinct acoul)>1;

-- question 9
SELECT anom as article
FROM articles NATURAL JOIN catalogue
GROUP BY anom
HAVING count(distinct fid)=1;

-- question 10
SELECT lettre, count(lettre) as compteur FROM(
  SELECT substr(anom, 1, 1) as lettre FROM Articles 
  GROUP BY (anom)) as liste_lettres
GROUP BY lettre
ORDER BY lettre;

-- question 11
SELECT upper(lettres) as lettre, count(lettres) as compteur FROM(
  SELECT substring(CAST( acoul as text) from 1 for 1) as lettres
  FROM Articles GROUP BY aid) as liste_lettres
GROUP BY lettres
ORDER BY lettres;

-- question 12
SELECT * FROM articles JOIN catalogue ON articles.aid=catalogue.aid;
SELECT * FROM articles JOIN catalogue using(aid);
-- Contrairement à la jointure avec ON, la jointure avec using
-- regroupe les aid en une colonne comme le fait une jointure
-- naturelle.
