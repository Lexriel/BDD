
DROP TABLE if exists participer cascade;
DROP TABLE if exists cours cascade;
DROP TABLE if exists etudiants, profs cascade;

CREATE TABLE etudiants(
e_id int primary key,
e_nom varchar(30),
niveau varchar(20),
age int
);

CREATE TABLE profs(
prof_id int primary key,
prof_nom varchar(30),
lab_id int
);

CREATE TABLE cours(
c_id int primary key,
titre varchar(50),
horaire varchar(20),
salle varchar(20),
prof_id int
);

CREATE TABLE participer(
e_id int,
c_id int references cours(c_id)
  on update cascade on delete cascade,
primary key (e_id, c_id)
);

insert into etudiants values(051135593,'Marie Blanche','Master 1',21);
insert into etudiants values(060839453,'Charles Harry','Master 1',22);
insert into etudiants values(099354543,'Susanne Martin','Licence 3',20);
insert into etudiants values(322654189,'Lisa Marcheur','Licence 2',17);
insert into etudiants values(132977562,'Angela Martinet','Master 1',20);
insert into etudiants values(269734834,'Thomas Robet','Licence 2',18);


insert into profs values(142519864,'I. Boulala',20);
insert into profs values(242518965,'Anael Klein',68);
insert into profs values(141582651,'Joris Robillard',20);
insert into profs values(489221823,'X. Boulala',70);

insert into cours values(1,'Structures de Donnees','LuMeVe 10','R128',489456522);
insert into cours values(2,'Systemes de Bases de Donnees','LuMeVe 12:30-1:45',
       '1320 DCL',142519864);
insert into cours values(3,'Conception de Systemes d Exploitation',
       'MaJeu 12-1:20','20 AVW',489456522 );
insert into cours values(20,'Reseaux','MaMe 9:30-10:45','20 AVW',141582651);
Insert into cours values(21,'Informatique legale','MaJeu 12:30-1:45','R15',254099823);
insert into cours values(22,'Intelligence artificielle',null,'UP328',null);
insert into cours values(23,'Securite','MaJeu 8-9:30','R128',489221823);

insert into participer values(112348546,2);
insert into participer values(115987938,2);
insert into participer values(348121549,2);
insert into participer values(322654189,2);
insert into participer values(552455318,2);
insert into participer values(455798411,3);
insert into participer values(552455318,3);
