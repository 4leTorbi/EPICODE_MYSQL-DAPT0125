-- DROP SCHEMA IF EXISTS CINEMA;
CREATE schema CINEMA;
USE CINEMA;

-- DROP TABLE IF EXISTS ATTORI;
CREATE TABLE ATTORI(
ID_ATTORE int
, NOME varchar(12)
, COGNOME varchar(20)
, ID_FILM int
, ID_REGISTA int	
, PREMI_VINTI int
, constraint PK_ATTORI primary key (ID_ATTORE)
, constraint FK_REGISTI_ATTORI foreign key (ID_REGISTA) references REGISTI(ID_REGISTA)
, constraint FK_FILM_ATTORI foreign key (ID_FILM) references FILM(ID_FILM)
);

-- DROP TABLE IF EXISTS REGISTI;
CREATE TABLE REGISTI (
ID_REGISTA INT
, NOME varchar(12)
, COGNOME varchar(20)
, ID_STUDIO int
, ID_FILM int
, ID_ATTORE int
, PREMI_VINTI int
, constraint PK_REGISTI primary key (ID_REGISTA)
);

ALTER TABLE REGISTI
ADD constraint FK_ATTORI_REGISTI foreign key (ID_ATTORE) REFERENCES ATTORI (ID_ATTORE)
, ADD constraint FK_FILM_REGISTI foreign key (ID_FILM) references FILM (ID_FILM)
;

-- DROP TABLE IF EXISTS STUDIO ;
CREATE TABLE STUDIO (
ID_STUDIO int	
, NOME VARCHAR(50)	
, LUOGO varchar(50)	
, ID_FILM int	
, ID_REGISTA int	
, ID_ATTORE INT
, constraint PK_STUDIO PRIMARY KEY (ID_STUDIO)
);

ALTER table STUDIO
ADD constraint FK_FILM_STUDIO foreign key (ID_FILM) references FILM (ID_FILM)
;

-- DROP TABLE IF EXISTS FILM ;
CREATE TABLE FILM (
ID_FILM int
, NOME varchar (40)	
, ID_GENERE int	
, ID_STUDIO int
, ID_REGISTA INT		
, ID_ATTORE int	
, PREMI_VINTI int
, constraint PK_FILM primary key (ID_FILM)
);

ALTER TABLE FILM
ADD constraint FK_GENERI_FILM foreign key (ID_GENERE) references GENERI (ID_GENERE)
, ADD constraint FK_STUDIO_FILM foreign key (ID_STUDIO) references STUDIO (ID_STUDIO)
, ADD constraint FK_ATTORI_FILM foreign key (ID_ATTORE) references ATTORI (ID_ATTORE)
, ADD constraint FK_REGISTI_FILM foreign key (ID_REGISTA) references REGISTI (ID_REGISTA)
;

-- DROP TABLE IF EXISTS GENERI ;
CREATE TABLE GENERI (
ID_GENERE int
, NOME varchar(20)
, ID_FILM INT
, constraint PK_GENERI primary key (ID_GENERE)
);


