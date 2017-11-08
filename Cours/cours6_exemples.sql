---- BDD Licence Informatique, FIL, Universite Lille1
---- exemples du cours 6 du 7 octobre 2015
-- auteur: Celine Kuttler

---Q1: articles non fournissables
--- requetes equivalentes

select * from articles where aid <>ALL (select aid from catalogue);

select * from articles where aid NOT IN (select aid from catalogue);

select * from articles a where NOT EXISTS (select * from catalogue c where c.aid=a.aid);


---Q2 tel que sur transparents: supprimee



---Q2: l'article le moins cher
--- requetes equivalentes

select * from catalogue where prix <= ALL (select prix from catalogue);

select * from catalogue c where NOT EXISTS (select * from catalogue c2 where c2.prix < c.prix);

select * from catalogue where prix IN (select min(prix) from catalogue);


---Q3:  articles avec au moins 2 fournisseurs
--- requetes equivalentes

select aid 
from catalogue c 
where  fid <> some(select fid from catalogue c2 where c2.aid=c.aid);
--- le style de cette requete n'est pas ideal. l'utilisation d'une variable de correlation c dans la sous-requete est lourde.


select aid from catalogue group by aid having count(distinct fid) >= 2;

select distinct c1.aid 
from catalogue c1 join catalogue c2 on c2.aid=c1.aid
where c2.fid<>c1.fid;

select distinct aid 
from catalogue c1 
where exists (select * from catalogue c2 where c1.aid=c2.aid and c1.fid<>c2.fid) ;


--- Q4: vendeur offrant aussi bien du  rouge que du vert

select fid
from catalogue natural join articles
where acoul='vert' and
      fid = SOME (select fid from catalogue natural join articles where acoul='rouge');


select fid
from catalogue natural join articles
where acoul='vert' and
      fid IN (select fid from catalogue natural join articles where acoul='rouge');

select fid
from catalogue c natural join articles
where acoul='vert'
and EXISTS (
    select * 
    from catalogue c2 natural join articles
    where acoul='rouge'
    and c2.fid=c.fid
);


(select fid
from catalogue natural join articles
where acoul='vert')
INTERSECT
(select fid
from catalogue natural join articles
where acoul='rouge');


------Q5  monopolistes et leur articles
--- pas vu en amphi

select fid,aid from catalogue c
where NOT EXISTS
      (select * from catalogue c2 
      where c2.aid=c.aid and c2.fid<>c.fid);


---Q6 fournisseur de TOUS les articles rouges
-- autrement dit: un fournisseur, tel qu'il n'existe pas d'article rouge, que ce fournisseur ne vende pas
-- autrement dit: un fournisseur, tel qu'il n'existe pas d'article rouge, tel qu'il n'existe pas de ligne du catalogue pour ce fournisseur et cet article
-- cette derniere version s'exprime en SQL de la maniere suivante:

select fid
from fournisseurs f
where not exists
      (
      select * from articles a 
      where acoul='rouge'
      	     and not exists (
	     select * from catalogue c where c.aid=a.aid and f.fid=c.fid
	     )
	     );

--- alternative: compter le nombre d'articles rouges, et comparer avec le nombre d'articles rouges vendus par ce fournisseur.

select fid
from catalogue natural join articles
where acoul='rouge'
group by fid
having count (aid)= (select count(aid) from articles where acoul='rouge');


---Q7 vendeur de TOUS les articles
--- pas vu en amphi

