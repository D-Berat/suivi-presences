-- BESOINS ENSEIGNANT (Rôle : Role_Enseignant)


-- Règle de gestion 16 : Un enseignant affiche la liste des étudiants de son groupe pour faire l'appel
-- Contexte : Personne005 ENSEIGNANT005 (E_HAMO) récupère les élèves du groupe G_BUT1_TD11 pour la séance S_BUT1_01
SELECT E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant
FROM ETUDIANT E
JOIN APPARTENIR A ON E.ine_etudiant = A.ine_etudiant
JOIN SEANCE S ON A.id_groupe = S.id_groupe
WHERE S.id_seance = 'S_BUT1_01' AND S.id_enseignant = 'E_HAMO'
ORDER BY E.nom_etudiant ASC;

-- Règle de gestion 17 : Consultation des séances selon les types de cours (CM, TD, TP, EVALUATION, PROJET)
-- Un enseignant liste les séances de type 'TD' planifiées pour vérifier son calendrier d'enseignement
SELECT id_seance, date_seance, heureDebut_seance, duree_seance, id_groupe, id_discipline
FROM SEANCE
WHERE type_seance = 'TD'
ORDER BY date_seance ASC, heureDebut_seance ASC;

-- Règle de gestion 20 : Vérification qu'un étudiant concerné par une séance possède exactement un état de présence
-- Identifie les anomalies où un étudiant du groupe n'a pas encore été évalué/appelé lors de la séance S_BUT1_01
SELECT E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant
FROM ETUDIANT E
JOIN APPARTENIR A ON E.ine_etudiant = A.ine_etudiant
JOIN SEANCE S ON A.id_groupe = S.id_groupe
LEFT JOIN PRESENCE P ON S.id_seance = P.id_seance AND E.ine_etudiant = P.ine_etudiant
WHERE S.id_seance = 'S_BUT1_01' AND P.etat_presence IS NULL;


-- BESOINS SÉCRÉTARIAT / SCOLARITÉ (Rôle : Role_Secretaire)


-- Règle de gestion 21 : Filtrage et extraction des anomalies d'assiduité selon la liste prédéfinie
-- Extrait l'ensemble des signalements (hors 'Présent') nécessitant le traitement ou la relance d'un justificatif
SELECT id_seance, id_groupe, ine_etudiant, etat_presence
FROM PRESENCE
WHERE etat_presence IN ('Absent', 'En retard', 'Absence excusée', 'Absence justifiée')
ORDER BY id_seance ASC;

-- Règle de gestion 22 : Modification administrative des données d'assiduité par le secrétariat
-- Contexte : Régularisation de l'état d'Personne004 ETUDIANT004 (22005892) suite à la réception d'un justificatif médical
UPDATE PRESENCE
SET etat_presence = 'Absence justifiée'
WHERE id_seance = 'S_BUT1_01' AND ine_etudiant = '22005892' AND id_groupe = 'G_BUT1_TD11';

-- Règle de gestion 25 : Export plat des absences structuré pour la génération du fichier d'établissement CSV
-- Génère le jeu de données dénormalisé requis pour l'importation sur la plateforme UMTICE
SELECT P.id_seance, S.date_seance, S.heureDebut_seance, D.code_discipline, P.id_groupe, 
       E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant, P.etat_presence
FROM PRESENCE P
JOIN ETUDIANT E ON P.ine_etudiant = E.ine_etudiant
JOIN SEANCE S ON P.id_seance = S.id_seance
JOIN DISCIPLINE D ON S.id_discipline = D.id_discipline
WHERE P.etat_presence NOT IN ('Présent')
ORDER BY S.date_seance DESC, E.nom_etudiant ASC;


-- BESOINS DIRECTION DES ÉTUDES (Rôle : Role_DirecteurEtudes)


-- Règle de gestion 10 : Contrôle des cumuls (Un étudiant rattaché à plusieurs groupes simultanément)
-- Permet au Directeur des études de vérifier la cohérence des inscriptions administratives multiples
SELECT E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant, COUNT(A.id_groupe) AS Nombre_Groupes_Affectes
FROM ETUDIANT E
JOIN APPARTENIR A ON E.ine_etudiant = A.ine_etudiant
GROUP BY E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant
HAVING COUNT(A.id_groupe) > 1;

-- Règle de gestion 24 : Bilan d'assiduité global par étudiant pour le passage en jury (Calcul des heures manquées)
-- Agrège le total d'absences injustifiées/justifiées et somme le volume d'heures de cours perdues
SELECT E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant,
       COUNT(CASE WHEN P.etat_presence = 'Absent' THEN 1 END) AS Absences_Injustifiees,
       COUNT(CASE WHEN P.etat_presence = 'Absence justifiée' THEN 1 END) AS Absences_Justifiees,
       COUNT(CASE WHEN P.etat_presence = 'En retard' THEN 1 END) AS Total_Retards,
       SUM(CASE WHEN P.etat_presence = 'Absent' THEN S.duree_seance ELSE 0 END) AS Minutes_Cours_Perdues
FROM ETUDIANT E
JOIN PRESENCE P ON E.ine_etudiant = P.ine_etudiant
JOIN SEANCE S ON P.id_seance = S.id_seance
GROUP BY E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant
ORDER BY Minutes_Cours_Perdues DESC;