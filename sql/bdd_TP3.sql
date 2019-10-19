DROP DATABASE IF EXISTS trocAngular;
CREATE DATABASE trocAngular;
use trocAngular;

CREATE TABLE COMPTES (
IDCOMPTE int(2) NOT NULL AUTO_INCREMENT,
PRENOMCOMPTE varchar(30) NOT NULL,
NOMCOMPTE varchar(30) NOT NULL,
PASSWORDCOMPTE char(40) NOT NULL,
PRIMARY KEY (IDCOMPTE)
);

CREATE TABLE NOTIFICATIONS (
IDNOT int(2) NOT NULL AUTO_INCREMENT,
CONTENT varchar(100) NOT NULL,
IDCOMPTE int(2) NOT NULL,
PRIMARY KEY (IDNOT),
FOREIGN KEY (IDCOMPTE) references COMPTES(IDCOMPTE)
);

CREATE TABLE MP ( /* Messages privés */
IDMP int(4) NOT NULL AUTO_INCREMENT,
IDCOMPTESRC int(2) NOT NULL,
IDCOMPTEDST int(2) NOT NULL,
DATEANDTIME datetime NOT NULL,
OBJET varchar(30) NOT NULL,
CONTENT varchar(500) NOT NULL,
PRIMARY KEY (IDMP),
FOREIGN KEY (IDCOMPTESRC) references COMPTES(IDCOMPTE),
FOREIGN KEY (IDCOMPTEDST) references COMPTES(IDCOMPTE)
);

CREATE TABLE CATEGORIES(
IDCAT int(2) NOT NULL AUTO_INCREMENT,
NOMC varchar(30) NOT NULL,
PRIMARY KEY (IDCAT)
);

CREATE TABLE JOUETS (
IDJ int(2) NOT NULL AUTO_INCREMENT,
IDCAT int(2) NOT NULL,
NOMJ varchar(30) NOT NULL,
IDCOMPTE int(2) NOT NULL,
DESCRIPTION varchar(240) NOT NULL,
STATUT enum("public","prive") NOT NULL,
PRIMARY KEY (IDJ),
FOREIGN KEY (IDCOMPTE) references COMPTES(IDCOMPTE),
FOREIGN KEY (IDCAT) references CATEGORIES(IDCAT)
);

CREATE TABLE DEMANDETROC (
IDTROC int(2) NOT NULL AUTO_INCREMENT,
IDCOMPTESRC int(2) NOT NULL,
IDJSRC int(2) NOT NULL,
IDCOMPTEDST int(2) NOT NULL,
IDJDST int(2) NOT NULL,
PRIMARY KEY (IDTROC),
FOREIGN KEY (IDCOMPTESRC) references COMPTES(IDCOMPTE),
FOREIGN KEY (IDJSRC) references JOUETS(IDJ),
FOREIGN KEY (IDCOMPTEDST) references COMPTES(IDCOMPTE),
FOREIGN KEY (IDJDST) references JOUETS(IDJ)
);
