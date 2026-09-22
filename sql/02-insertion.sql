-- 1. FORMATIONS (6 enregistrements de formations)

INSERT INTO FORMATION (libelle_formation, annee_formation) VALUES
('BUT Informatique', 2026),
('BUT Réseaux et Télécoms', 2026),
('BUT GEII', 2026),
('BUT Gestion des Entreprises', 2026),
('BUT Métiers du Multimédia', 2026),
('BUT Génie Biologique', 2026);


-- 2. PROMOTIONS (6 enregistrements de promotions)

INSERT INTO PROMOTION (id_promotion, code_promotion, libelle_promotion, libelle_formation) VALUES
('PR_BUT1', 'BUT1', 'BUT Informatique - 1ère Année', 'BUT Informatique'),
('PR_BUT2', 'BUT2', 'BUT Informatique - 2ème Année', 'BUT Informatique'),
('PR_BUT3', 'BUT3', 'BUT Informatique - 3ème Année', 'BUT Informatique'),
('PR_RT1', 'RT1', 'BUT Réseaux - 1ère Année', 'BUT Réseaux et Télécoms'),
('PR_GE1', 'GEII1', 'BUT GEII - 1ère Année', 'BUT GEII'),
('PR_GA1', 'GEA1', 'BUT GEA - 1ère Année', 'BUT Gestion des Entreprises');


-- 3. GROUPES (6 enregistrements de groupes)

INSERT INTO GROUPE (id_groupe, code_groupe, libelle_groupe, id_promotion) VALUES
('G_BUT1_TD11', 'TD11', 'Groupe TD 11', 'PR_BUT1'),
('G_BUT1_TD12', 'TD12', 'Groupe TD 12', 'PR_BUT1'),
('G_BUT2_TD21', 'TD21', 'Groupe TD 21', 'PR_BUT2'),
('G_BUT2_TD22', 'TD22', 'Groupe TD 22', 'PR_BUT2'),
('G_BUT3_TD31', 'TD31', 'Groupe TD 31', 'PR_BUT3'),
('G_BUT3_TD32', 'TD32', 'Groupe TD 32', 'PR_BUT3');


-- 4. DISCIPLINES (8 enregistrements de disciplines)

INSERT INTO DISCIPLINE (id_discipline, code_discipline, libelle_discipline, id_promotion) VALUES
('D_R105', 'R1.05', 'Introduction aux bases de données', 'PR_BUT1'),
('D_R104', 'R1.04', 'Introduction aux systèmes', 'PR_BUT1'),
('D_R106', 'R1.06', 'Mathématiques discrètes', 'PR_BUT1'),
('D_R204', 'R2.04', 'Exploitation d''une base de données', 'PR_BUT2'),
('D_R306', 'R3.06', 'Architecture des réseaux', 'PR_BUT2'),
('D_R404', 'R4.04', 'Méthodes d''optimisation', 'PR_BUT2'),
('D_R605', 'R6.05', 'Développement avancé', 'PR_BUT3'),
('D_R505', 'R5.05', 'Programmation avancée', 'PR_BUT3');


-- 5. ENSEIGNANTS (6 enregistrements d'enseignants)

INSERT INTO ENSEIGNANT (id_enseignant, nom_enseignant, prenom_enseignant, email_enseignant) VALUES
('E_ROUL', 'ENSEIGNANT001', 'Personne001', 'enseignant001@example.org'),
('E_BRUN', 'ENSEIGNANT002', 'Personne002', 'enseignant002@example.org'),
('E_LAFO', 'ENSEIGNANT003', 'Personne003', 'enseignant003@example.org'),
('E_WALK', 'ENSEIGNANT004', 'Personne004', 'enseignant004@example.org'),
('E_HAMO', 'ENSEIGNANT005', 'Personne005', 'enseignant005@example.org'),
('E_BROC', 'ENSEIGNANT006', 'Personne006', 'enseignant006@example.org');


-- 6. ETUDIANTS (6 enregistrements d'étudiants)

INSERT INTO ETUDIANT (ine_etudiant, nom_etudiant, prenom_etudiant, email_etudiant, telephone_etudiant) VALUES
('22001452', 'ETUDIANT001', 'Personne001', 'etudiant001@example.org', '0611223344'),
('22003698', 'ETUDIANT002', 'Personne002', 'etudiant002@example.org', '0622334455'),
('22004781', 'ETUDIANT003', 'Personne003', 'etudiant003@example.org', '0655667788'),
('22005892', 'ETUDIANT004', 'Personne004', 'etudiant004@example.org', '0666778899'),
('22006903', 'ETUDIANT005', 'Personne005', 'etudiant005@example.org', '0677889900'),
('22009999', 'ETUDIANT006', 'Personne006', 'etudiant006@example.org', '0688990011');


-- 7. SEANCES (9 enregistrements de séances)

INSERT INTO SEANCE (id_seance, date_seance, heureDebut_seance, duree_seance, type_seance, id_groupe, id_enseignant, id_discipline) VALUES
('S_BUT1_01', '2026-06-01', '08:00:00', 90, 'TD', 'G_BUT1_TD11', 'E_HAMO', 'D_R105'),
('S_BUT1_02', '2026-06-01', '09:45:00', 90, 'TP', 'G_BUT1_TD11', 'E_BRUN', 'D_R104'),
('S_BUT1_03', '2026-06-01', '14:00:00', 90, 'TD', 'G_BUT1_TD12', 'E_WALK', 'D_R106'),
('S_BUT2_01', '2026-06-02', '08:00:00', 90, 'TD', 'G_BUT2_TD21', 'E_HAMO', 'D_R204'),
('S_BUT2_02', '2026-06-02', '09:45:00', 90, 'TP', 'G_BUT2_TD21', 'E_BRUN', 'D_R306'),
('S_BUT2_03', '2026-06-02', '14:00:00', 90, 'CM', 'G_BUT2_TD22', 'E_WALK', 'D_R404'),
('S_BUT3_01', '2026-06-03', '08:00:00', 90, 'CM', 'G_BUT3_TD31', 'E_HAMO', 'D_R605'),
('S_BUT3_02', '2026-06-03', '10:30:00', 90, 'TD', 'G_BUT3_TD31', 'E_BROC', 'D_R505'),
('S_BUT3_03', '2026-06-03', '14:00:00', 90, 'TP', 'G_BUT3_TD32', 'E_BROC', 'D_R605');


-- 8. APPARTENIR (9 enregistrements)

INSERT INTO APPARTENIR (id_groupe, ine_etudiant) VALUES
('G_BUT1_TD11', '22004781'),
('G_BUT1_TD11', '22005892'),
('G_BUT1_TD12', '22006903'),
('G_BUT1_TD12', '22009999'),
('G_BUT2_TD21', '22001452'),
('G_BUT2_TD21', '22003698'),
('G_BUT2_TD22', '22001452'),
('G_BUT3_TD31', '22001452'),
('G_BUT3_TD32', '22003698');


-- 9. PRESENCE (14 appels - cohérence id_groupe / ine_etudiant / id_seance)

INSERT INTO PRESENCE (id_groupe, ine_etudiant, id_seance, etat_presence) VALUES
('G_BUT1_TD11', '22004781', 'S_BUT1_01', 'Présent'),
('G_BUT1_TD11', '22005892', 'S_BUT1_01', 'Absent'),
('G_BUT1_TD11', '22004781', 'S_BUT1_02', 'En retard'),
('G_BUT1_TD11', '22005892', 'S_BUT1_02', 'Absence justifiée'),
('G_BUT1_TD12', '22006903', 'S_BUT1_03', 'Présent'),
('G_BUT1_TD12', '22009999', 'S_BUT1_03', 'Présent'),
('G_BUT2_TD21', '22001452', 'S_BUT2_01', 'Présent'),
('G_BUT2_TD21', '22003698', 'S_BUT2_01', 'Absent'),
('G_BUT2_TD21', '22001452', 'S_BUT2_02', 'Présent'),
('G_BUT2_TD21', '22003698', 'S_BUT2_02', 'En retard'),
('G_BUT2_TD22', '22001452', 'S_BUT2_03', 'Présent'),
('G_BUT3_TD31', '22001452', 'S_BUT3_01', 'Présent'),
('G_BUT3_TD31', '22001452', 'S_BUT3_02', 'Présent'),
('G_BUT3_TD32', '22003698', 'S_BUT3_03', 'Absent');