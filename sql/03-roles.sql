-- 1 CREATION DES ROLES
CREATE ROLE Role_Secretaire;
CREATE ROLE Role_Enseignant;
CREATE ROLE Role_DirecteurEtudes;

-- 2 CREATION DES VUES DE RESTRICTION
GO
-- Règle 22 : Formations et disciplines accessibles uniquement en lecture pour la secrétaire
CREATE VIEW Vue_Secretaire_Formation AS 
SELECT libelle_formation, annee_formation FROM FORMATION;
GO
CREATE VIEW Vue_Secretaire_Discipline AS 
SELECT id_discipline, code_discipline, libelle_discipline, id_promotion FROM DISCIPLINE;
GO

-- Règle 24 : Formations accessibles uniquement en lecture pour le directeur des études
CREATE VIEW Vue_DirEtudes_Formation AS 
SELECT libelle_formation, annee_formation FROM FORMATION;
GO

-- 3 ATTRIBUTION DES PRIVILEGES

-- PROFIL : SECRÉTAIRE (Règle 22)
GRANT SELECT, INSERT, UPDATE, DELETE ON PROMOTION TO Role_Secretaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON GROUPE TO Role_Secretaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON ETUDIANT TO Role_Secretaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON ENSEIGNANT TO Role_Secretaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON SEANCE TO Role_Secretaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON APPARTENIR TO Role_Secretaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRESENCE TO Role_Secretaire;
GRANT SELECT ON Vue_Secretaire_Formation TO Role_Secretaire;
GRANT SELECT ON Vue_Secretaire_Discipline TO Role_Secretaire;

-- PROFIL : ENSEIGNANT (Règle 23)
GRANT SELECT ON FORMATION TO Role_Enseignant;
GRANT SELECT ON PROMOTION TO Role_Enseignant;
GRANT SELECT ON GROUPE TO Role_Enseignant;
GRANT SELECT ON DISCIPLINE TO Role_Enseignant;
GRANT SELECT ON ETUDIANT TO Role_Enseignant;
GRANT SELECT ON ENSEIGNANT TO Role_Enseignant;
GRANT SELECT ON APPARTENIR TO Role_Enseignant;
GRANT SELECT, INSERT, UPDATE, DELETE ON SEANCE TO Role_Enseignant;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRESENCE TO Role_Enseignant;

-- PROFIL : DIRECTEUR DES ÉTUDES (Règle 24)
GRANT SELECT, INSERT, UPDATE, DELETE ON PROMOTION TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON GROUPE TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ETUDIANT TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ENSEIGNANT TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON DISCIPLINE TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON SEANCE TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON APPARTENIR TO Role_DirecteurEtudes;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRESENCE TO Role_DirecteurEtudes;
GRANT SELECT ON Vue_DirEtudes_Formation TO Role_DirecteurEtudes;