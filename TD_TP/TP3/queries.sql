----- estimation de difficulte: 
--f--   facile
--m-- moyen
--d--  difficile





--- Q 1
--f -- par article (nom d'article!), le nombre de couleurs  dans lequel l'article est decliné
select  anom as ARTICLE , count (distinct acoul) as NB_COUL
from articles
group by anom ;


--- Q 2
--m - -- noms des articles fournissables, 
-- avec prix maximal et minimal, 
-- uniquement pour les articles avec plus d'un vendeur

select  anom,  min(prix), max(prix), count(distinct fid) as "NB_F", count(distinct acoul) as "NB_C", count(*) as "TOUT"
from articles , catalogue 
where articles.aid=catalogue.aid 
group by articles.anom 
having count(distinct fid)>1;


--- Q 3
--m-- les couleurs "rares", pour lesquelles il n'y a qu'un  seul article 
select acoul as CouleursRares
from articles
group by acoul
having count(*) = 1;




--- Q 4 (2015)
--m-- par couleur, sous condition que plus d'un article ce cette couleur soit fournissable,le prix moyen, en excluant la ferrari rouge.
-- trier  par prix moyen decroissant
select  acoul as Couleur , avg (prix) as PrixMoyen 
from articles, catalogue
where articles.aid=catalogue.aid and anom not like 'Ferrari%'
group by acoul 
having count (distinct articles.aid) > 1
order by avg(prix) desc;



--- Q5
--f-- par article fournissable, et par couleur de l'article, 
-- le  nombre de vendeurs offrant l'article dans cette couleur

select  anom , acoul, count( distinct fid) as "nombre de fournisseurs" 
from articles , catalogue 
where articles.aid=catalogue.aid 
group by articles.anom,  articles.acoul; 


--- Q6 
---m - par article, le nombre de fournisseurs (meme si zero)

select  anom as "ARTICLE", count(distinct  fid)   as "NB_F"
from articles left join catalogue       
on articles.aid=catalogue.aid                                               
 group by articles.anom                                                      
;






-- --m-- le nom de l'article le plus cher, et son prix
-- select a.anom, c.prix
-- from catalogue c, articles a 
-- where c.aid=a.aid
-- and c.prix = (select max (prix) from catalogue);

-- --- Q 
-- --m-- le nom du vendeur de l'article le plus cher
-- select f.fnom
-- from catalogue c, fournisseurs f
-- where c.fid=f.fid
-- and c.prix=(select max(prix) from catalogue);

--- Q7
--m- les noms des vendeurs offrant  plus d'un article , et le nombre d'articles qu'ils vendent

select fnom as Fournisseur , count(distinct anom) as NbArticles
from catalogue c, fournisseurs f, articles a
where c.fid=f.fid and a.aid=c.aid
group by c.fid,fnom
having count (distinct anom) >1;

--- alexandre
SELECT fnom as "Fournisseurs", count(distinct anom) as "nbArticles"
FROM fournisseurs NATURAL JOIN catalogue NATURAL JOIN articles
GROUP BY fnom 
HAVING count(distinct (anom,acoul)) > 1;
--  un vendeur passe, si il a un seul article en deux couleurs!


--- Q8
---m-- selectionner les ids des vendeurs qui vendent un meme 
---article en differentes couleurs

select  fnom as "FOURNISSEUR", anom as "ARTICLE", count(acoul) as "NB_COUL"
from articles natural join catalogue natural join fournisseurs f
group by fnom, anom
having count (*) > 1;


--- Q7
--m-- selectionnner le nom du fournisseur qui vend le meme article 
-- en plusieurs couleurs 
-- et le nom de l'artcile concerné.
select  fnom, anom
from articles, catalogue,fournisseurs
where articles.aid = catalogue.aid and catalogue.fid=fournisseurs.fid
group by catalogue.fid, anom,fnom
having count (distinct articles.acoul) > 1;

--- Q 
--f-- selectionner, par article, le nombre de vendeurs
--select  articles.anom , count (distinct catalogue.fid) as NbVendeurs
--from articles, catalogue,fournisseurs
--where articles.aid = catalogue.aid and catalogue.fid=fournisseurs.fid
--group by articles.anom;


------- a rendre: Q15 inclus -----------


-- --- Q 12
-- --m-- tp4: 3.12 avec group by et having
-- -- articles avec plus d'un vendeur. 
-- --- donner les aids pour les articles.
-- --- trier les aids en ordre croissant.
-- select aid 
-- from catalogue 
-- group by aid having count(fid) > 1



--- Q 
--m-- par article (nom d'article), le nombre de fournisseurs. 
-- trier par ordre decroissant: les articles avec le plus de vendeurs en premier.
-- select  anom as "article", count(distinct  fid)   as "nombre de fournisseurs"
-- from articles , catalogue 
-- where articles.aid=catalogue.aid 
-- group by articles.anom 
-- order by count(distinct fid) desc;


--- Q 
-- --m-- par couleur, sous condition qu'on ait plus d'un article ce cette couleur,
-- -- le prix moyen, en excluant la ferrari rouge.
-- select  acoul  , avg (prix) as PrixMoyen 
-- from articles, catalogue
-- where articles.aid=catalogue.aid and anom not like 'Ferrari%'
-- group by acoul 
-- having count(*)>1
-- order by avg(prix);



-- --- Q 16
-- --d-- le nombre d'articles offert par le vendeur avec le plus grand choix d'articles
-- -- given for group 4
-- select max (n.c) 
-- from  (
--       select count (*)  as c, fid
--       from catalogue
--       group by fid 
-- ) 
-- as n;

-- -- via  view

-- create view ChoixParFournisseur(fid,nbarticles)
-- as 
--      select fid, count (*)  
--       from catalogue
--       group by fid 
-- ;

-- select fid,nbarticles 
-- from ChoixParFournisseur
-- where nbarticle = 
-- (select max(nbarticles) from ChoixParFournisseur);
-- ---

-- select count(*)
-- from catalogue
-- group by fid
-- having count(*)>=
-- all(select count(*) from catalogue group by fid);


-- --- Q 17
-- --d-- le nom du vendeur avec le plus grand choix d'articles

-- select fnom 
-- from catalogue c, fournisseurs f
-- where c.fid=f.fid
-- group by c.fid,fnom
-- having count(*) = 
--        (
-- 	select max (n.c) from (
-- 	select count (*)  as c
-- 	from catalogue	  
-- 	group by fid ) as n
-- );

-- ---- still doesn't work...
-- select fnom 
-- from fournisseurs f 
--      join 
--      (
--      select max (n.c) as m, n.fid from 
--        ( select count (*)  as c, fid from catalogue group by fid )  as n
--        group by n.fid) 
--        as TT
--        on TT.fid=mf.fid
-- where TT.m=(select max(m) from TT);

-- ---- maybe the easiest to read?

-- select fnom 
-- from catalogue c, fournisseurs f
-- where c.fid=f.fid
-- group by c.fid, fnom
-- having count(*) >= all 
--        (select count(*) from catalogue group by fid);


--- Q 9
---m-- selectionnner les noms des articles offerts par un seul vendeur, toutes couleurs confondues
-- nice!

select  anom
from articles a,  catalogue c, fournisseurs f
where a.aid = c.aid and c.fid=f.fid
group by anom
having count (distinct fnom) =1;

select a.anom 
from articles a,catalogue c
where 
a.aid=c.aid and 
not exists 
(
select * from catalogue c2,articles a2 
where 
c2.aid=a2.aid
and c2.fid<>c.fid
and a2.anom=a.anom
);


--- Q10
select substring(upper(string(acoul)) from 1 for 1) as Lettre , count(distinct anom) from articles group by Lettre order by Lettre;


---- Q11
select upper(substring(CAST(acoul as varchar) from 1 for 1)) as C, count(*) from articles group by C order by C;



--------------========== end 2015==============================
-- --- Q19
-- select anom, count(*)
-- from articles left join (select * from catalogue) as R on articles.aid=R.aid
-- where R.aid is NULL
-- group by anom;


--- Q20
select t.anom, count(*)
from (select a.aid, a.anom
     from articles a
     except
   ( select a2.aid, a2.anom
     from articles a2, catalogue c
     where a2.aid = c.aid)) as t
group by t.anom;


--d-- selectionner les fids des monopolistes, avec le nom de l'article pour lequel ils ont le monopole
---- THIS IS A HACK! NOT OBVIOUS!
select   max(catalogue.fid)       as fid  , articles.anom
from articles, catalogue,fournisseurs                                                        
  where articles.aid = catalogue.aid and catalogue.fid=fournisseurs.fid              
            group by articles.anom                                                               
          having count (distinct fnom) =1;


select  catalogue.fid , articles.anom
from articles, catalogue                                          
where articles.aid = catalogue.aid        
group by articles.anom, catalogue.fid                                              
having count (distinct catalogue.fid) =1;

%2015: 
-- d -- selectionner les noms des monopolistes, c.a.d. vendeurs etant les seuls a offrir un certain article
select fnom as monopolistes 
from fournisseurs 
where fid in
(select   max(catalogue.fid)       as fid 
	  from articles, catalogue,fournisseurs                                                        
	    where articles.aid = catalogue.aid and catalogue.fid=fournisseurs.fid              
            group by articles.anom                                                               
             having count (distinct fnom) =1);

------------ FIN FIN FIN-----------------


--- can we do the same with another technique? or even better, with supplier name?
select c.fid, fnom, a.anom
from catalogue c, articles a, fournisseurs f
where 
      c.aid = a.aid and c.fid=f.fid and 
      not exists
      (select * 
      from catalogue c2, articles a2
      where c2.aid=a2.aid and c2.fid <> c.fid and a.anom=a2.anom
      );



-- ecrivez une requete qui vous permet de verifier que la reponse du corrigee est correcte,
-- en indiquant comment interpreter son resultat.
select *
from articles, catalogue
where articles.aid=catalogue.aid
order by fid;



