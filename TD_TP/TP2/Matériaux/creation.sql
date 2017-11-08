drop table articles;
drop table fournisseurs;
drop table catalogue;


CREATE TYPE colors as  ENUM('rouge','noir','argente','opaque','cyan','magenta','vert','superjaune');

CREATE TABLE Articles(
aid int primary key,                     
anom varchar(30), 
acoul colors
);



CREATE TABLE Catalogue(
fid int,   
aid int, 
prix numeric(8,2) 
);

CREATE TABLE Fournisseurs(
fid int,
fnom varchar(30),
fad varchar(70)
);




