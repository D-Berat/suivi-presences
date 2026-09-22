DROP TABLE IF EXISTS PRESENCE;
DROP TABLE IF EXISTS APPARTENIR;
DROP TABLE IF EXISTS SEANCE;
DROP TABLE IF EXISTS DISCIPLINE;
DROP TABLE IF EXISTS GROUPE;
DROP TABLE IF EXISTS PROMOTION;
DROP TABLE IF EXISTS FORMATION;
DROP TABLE IF EXISTS ETUDIANT;
DROP TABLE IF EXISTS ENSEIGNANT;

CREATE TABLE FORMATION(
   libelle_formation VARCHAR(50),
   annee_formation SMALLINT,
   PRIMARY KEY(libelle_formation)
);

CREATE TABLE PROMOTION(
   id_promotion VARCHAR(50),
   code_promotion VARCHAR(50),
   libelle_promotion VARCHAR(50),
   libelle_formation VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_promotion),
   FOREIGN KEY(libelle_formation) REFERENCES FORMATION(libelle_formation)
);

CREATE TABLE GROUPE(
   id_groupe VARCHAR(50),
   code_groupe VARCHAR(50),
   libelle_groupe VARCHAR(50),
   id_promotion VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_groupe),
   FOREIGN KEY(id_promotion) REFERENCES PROMOTION(id_promotion)
);

CREATE TABLE DISCIPLINE(
   id_discipline VARCHAR(50),
   code_discipline VARCHAR(50),
   libelle_discipline VARCHAR(50),
   id_promotion VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_discipline),
   FOREIGN KEY(id_promotion) REFERENCES PROMOTION(id_promotion)
);

CREATE TABLE ETUDIANT(
   ine_etudiant VARCHAR(50),
   nom_etudiant VARCHAR(40),
   email_etudiant VARCHAR(50),
   telephone_etudiant VARCHAR(15),
   prenom_etudiant VARCHAR(40),
   PRIMARY KEY(ine_etudiant)
);

CREATE TABLE ENSEIGNANT(
   id_enseignant VARCHAR(50),
   nom_enseignant VARCHAR(40),
   prenom_enseignant VARCHAR(40),
   email_enseignant VARCHAR(50),
   PRIMARY KEY(id_enseignant)
);

CREATE TABLE SEANCE(
   id_seance VARCHAR(50),
   date_seance DATE,
   heureDebut_seance TIME(0),
   duree_seance INT,
   type_seance VARCHAR(50),
   id_groupe VARCHAR(50) NOT NULL,
   id_enseignant VARCHAR(50) NOT NULL,
   id_discipline VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_seance),
   FOREIGN KEY(id_groupe) REFERENCES GROUPE(id_groupe),
   FOREIGN KEY(id_enseignant) REFERENCES ENSEIGNANT(id_enseignant),
   FOREIGN KEY(id_discipline) REFERENCES DISCIPLINE(id_discipline)
);

CREATE TABLE APPARTENIR(
   id_groupe VARCHAR(50),
   ine_etudiant VARCHAR(50),
   PRIMARY KEY(id_groupe, ine_etudiant),
   FOREIGN KEY(id_groupe) REFERENCES GROUPE(id_groupe),
   FOREIGN KEY(ine_etudiant) REFERENCES ETUDIANT(ine_etudiant)
);

CREATE TABLE PRESENCE(
   id_groupe VARCHAR(50),
   ine_etudiant VARCHAR(50),
   id_seance VARCHAR(50),
   etat_presence VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_groupe, ine_etudiant, id_seance),
   FOREIGN KEY(id_groupe, ine_etudiant) REFERENCES APPARTENIR(id_groupe, ine_etudiant),
   FOREIGN KEY(id_seance) REFERENCES SEANCE(id_seance)
);