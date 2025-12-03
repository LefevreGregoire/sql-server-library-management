USE TOUTLA_DB;
GO

-- Désactiver les messages de comptage pour plus de performance
SET NOCOUNT ON;

PRINT '>>> Début de l''insertion des données...';

-- =============================================
-- 1. INSERTION DES TABLES DE RÉFÉRENCE
-- =============================================

-- Éditeurs
INSERT INTO Editeur (Nom, Adresse, ContactEmail) VALUES 
('Gallimard', '5 rue Sébastien-Bottin, 75007 Paris', 'contact@gallimard.fr'),
('Actes Sud', 'Place Nina-Berberova, 13200 Arles', 'info@actes-sud.fr'),
('Albin Michel', '22 rue Huyghens, 75014 Paris', 'service@albin-michel.fr'),
('Flammarion', '87 quai Panhard et Levassor, 75013 Paris', 'contact@flammarion.fr'),
('Grasset', '61 rue des Saints-Pères, 75006 Paris', 'info@grasset.fr'),
('Le Seuil', '25 bd Romain-Rolland, 75014 Paris', 'contact@seuil.com'),
('Pocket', '12 avenue d''Italie, 75013 Paris', 'contact@pocket.fr'),
('Livre de Poche', '31 rue de Fleurus, 75006 Paris', 'info@livredepoche.com'),
('Folio', '5 rue Sébastien-Bottin, 75007 Paris', 'contact@folio-lesite.fr'),
('10/18', '12 avenue d''Italie, 75013 Paris', 'info@10-18.fr');

-- Rayons
INSERT INTO Rayon (Nom, Description) VALUES 
('Littérature Française', 'Romans et classiques français'),
('Littérature Étrangère', 'Romans traduits du monde entier'),
('Policier & Thriller', 'Polars, enquêtes et frissons'),
('Science-Fiction', 'Imaginaire, futur et magie'),
('Jeunesse', 'Livres pour enfants et adolescents'),
('Sciences Humaines', 'Histoire, sociologie, psychologie'),
('Vie Pratique', 'Cuisine, jardinage, bricolage'),
('Bande Dessinée', 'BD, Comics, Mangas'),
('Beaux Arts', 'Peinture, photographie, architecture'),
('Tourisme', 'Guides de voyage et cartes');

-- Auteurs
INSERT INTO Auteur (Nom, Prenom, Biographie) VALUES 
('Hugo', 'Victor', 'Écrivain romantique français.'),
('Camus', 'Albert', 'Philosophe et romancier, prix Nobel.'),
('Pennac', 'Daniel', 'Écrivain français, auteur de la saga Malaussène.'),
('King', 'Stephen', 'Le maître de l''horreur américain.'),
('Rowling', 'J.K.', 'Autrice de la célèbre saga Harry Potter.'),
('Nothomb', 'Amélie', 'Romancière belge prolifique.'),
('Musso', 'Guillaume', 'Auteur de best-sellers français.'),
('Levy', 'Marc', 'Écrivain français le plus lu à l''étranger.'),
('Gavalda', 'Anna', 'Romancière et nouvelliste française.'),
('Werber', 'Bernard', 'Auteur de la trilogie des Fourmis.'),
('Vargas', 'Fred', 'Romancière française de polars.'),
('Chattam', 'Maxime', 'Spécialiste du thriller français.'),
('Orwell', 'George', 'Écrivain anglais, auteur de 1984.'),
('Tolkien', 'J.R.R.', 'Le père de la Fantasy moderne.'),
('Zola', 'Émile', 'Chef de file du naturalisme.');

-- =============================================
-- 2. INSERTION DES LIVRES (Vrais + Générés)
-- =============================================

-- Insertion de 20 "Vrais" livres pour les démos
INSERT INTO Livre (ISBN, Titre, Resume, PrixHT, DateParution, EditeurID, RayonID_Principal, SeuilAlerte) VALUES 
('9782070413119', 'L''Étranger', 'Meursault, étranger à la société...', 8.50, '1942-01-01', 1, 1, 5),
('9782253006329', 'Germinal', 'La grève des mineurs...', 6.90, '1885-01-01', 8, 1, 5),
('9782266202023', 'Misery', 'Un écrivain séquestré...', 9.20, '1987-06-08', 7, 3, 5),
('9780747532743', 'Harry Potter à l''école des sorciers', 'Un sorcier à Poudlard.', 22.00, '1997-06-26', 1, 5, 10),
('9782226195928', 'Les Fourmis', 'Nous ne sommes pas seuls...', 21.50, '1991-03-01', 3, 4, 5),
('9782290307116', 'Pars vite et reviens tard', 'Des signes étranges sur les portes...', 8.10, '2001-01-01', 6, 3, 5),
('9782070368228', '1984', 'Big Brother vous regarde.', 9.90, '1949-06-08', 1, 4, 10),
('9782264022500', 'Le Seigneur des Anneaux T1', 'L''anneau unique.', 15.00, '1954-07-29', 7, 4, 5),
('9782253004226', 'Notre-Dame de Paris', 'Esmeralda et Quasimodo.', 7.50, '1831-03-16', 8, 1, 5),
('9782070360024', 'Au bonheur des Dames', 'L''essor des grands magasins.', 6.50, '1883-01-01', 9, 1, 5),
('9782226318761', 'Stupeur et Tremblements', 'Une employée au Japon.', 18.90, '1999-08-01', 3, 1, 5),
('9782266199972', 'La Ligne Verte', 'Dans le couloir de la mort.', 8.90, '1996-01-01', 7, 3, 5),
('9782253151371', 'Et si c''était vrai', 'Une histoire d''amour fantomatique.', 19.90, '2000-01-01', 8, 1, 5),
('9782290032724', 'Ensemble, c''est tout', 'La vie en colocation.', 20.50, '2004-01-01', 6, 1, 5),
('9782266071667', 'La Nuit des temps', 'Une civilisation perdue sous la glace.', 8.20, '1968-01-01', 7, 4, 5),
('9782253116042', 'L''Ame du mal', 'Trilogie du mal T1.', 22.00, '2002-01-01', 3, 3, 5),
('9782070377541', 'La Peste', 'Oran frappée par le fléau.', 10.50, '1947-01-01', 1, 1, 5),
('9782070407576', 'La Fée Carabine', 'Malaussène enquête.', 8.80, '1987-01-01', 9, 3, 5),
('9782266259270', 'Ça - Tome 1', 'Le clown maléfique.', 11.50, '1986-09-15', 3, 3, 5),
('9782253010692', 'Le Hobbit', 'Un voyage inattendu.', 7.90, '1937-09-21', 8, 4, 5);

-- Liaison Livre-Auteur pour les vrais livres
INSERT INTO Livre_Auteur (ISBN, AuteurID) VALUES 
('9782070413119', 2), ('9782253006329', 15), ('9782266202023', 4), ('9780747532743', 5),
('9782226195928', 10), ('9782290307116', 11), ('9782070368228', 13), ('9782264022500', 14),
('9782253004226', 1), ('9782070360024', 15), ('9782226318761', 6), ('9782266199972', 4),
('9782253151371', 8), ('9782290032724', 9), ('9782266071667', 10), ('9782253116042', 12),
('9782070377541', 2), ('9782070407576', 3), ('9782266259270', 4), ('9782253010692', 14);

-- Boucle pour générer 60 livres supplémentaires (Total > 80)
DECLARE @i INT = 1;
WHILE @i <= 65
BEGIN
    INSERT INTO Livre (ISBN, Titre, PrixHT, DateParution, EditeurID, RayonID_Principal, SeuilAlerte)
    VALUES (
        'GEN-00000' + CAST(@i AS VARCHAR),
        'Livre Catalogue Volume ' + CAST(@i AS VARCHAR),
        CAST(10 + (@i % 20) AS DECIMAL(10,2)),
        DATEADD(DAY, -@i, GETDATE()),
        (1 + (@i % 10)), -- Editeur aléatoire entre 1 et 10
        (1 + (@i % 10)), -- Rayon aléatoire entre 1 et 10
        5
    );
    SET @i = @i + 1;
END;

-- =============================================
-- 3. INSERTION DES ACTEURS (Clients, Vendeurs)
-- =============================================

-- Vendeurs
INSERT INTO Vendeur (Nom, Prenom, Email, IdRayonSpecialite) VALUES 
('Dubois', 'Pierre', 'p.dubois@toutla.fr', 1),
('Leroy', 'Marie', 'm.leroy@toutla.fr', 3),
('Moreau', 'Lucas', 'l.moreau@toutla.fr', 4),
('Petit', 'Sophie', 's.petit@toutla.fr', 5),
('Garcia', 'Julie', 'j.garcia@toutla.fr', 8);

-- Clients
INSERT INTO Client (TypeClient, Nom, Prenom, Email, Adresse, CodePostal, Ville, CarteFidelite, DateCreation) VALUES 
('Particulier', 'Martin', 'Thomas', 'thomas.martin@email.com', '12 rue des Lilas', '75001', 'Paris', 1, '2024-01-15'),
('Particulier', 'Bernard', 'Nathalie', 'n.bernard@email.com', '45 avenue de la République', '69002', 'Lyon', 0, '2024-02-20'),
('Particulier', 'Dubois', 'Thomas', 't.dubois@email.com', '8 impasse du Vert', '33000', 'Bordeaux', 1, '2024-03-10'),
('Particulier', 'Robert', 'Céline', 'c.robert@email.com', '102 boulevard Haussmann', '75008', 'Paris', 1, '2024-05-05'),
('Professionnel', 'Ecole Jean Jaurès', NULL, 'contact@ecole-jaures.fr', '10 rue de l''École', '75011', 'Paris', 0, '2023-09-01'),
('Professionnel', 'Bibliothèque Municipale', NULL, 'mediatheque@lyon.fr', '1 place de la Culture', '69000', 'Lyon', 0, '2023-06-15');

-- =============================================
-- 4. INITIALISATION DES STOCKS
-- =============================================
-- On met 15 exemplaires par défaut pour tous les livres
INSERT INTO Stock (RayonID, ISBN, Quantite, SeuilAlerte, Emplacement)
SELECT RayonID_Principal, ISBN, 15, 5, 'Etagère A'
FROM Livre;

-- Cas particulier : Stock critique pour "Harry Potter" et "1984" (pour tester les alertes)
UPDATE Stock SET Quantite = 2 WHERE ISBN = '9780747532743'; -- Harry Potter
UPDATE Stock SET Quantite = 3 WHERE ISBN = '9782070368228'; -- 1984

-- =============================================
-- 5. INSERTION DES ÉVÉNEMENTS
-- =============================================
INSERT INTO Evenement (Nom, DateEvent, AuteurInviteID, ResponsableID, Lieu) VALUES 
('Rencontre avec Amélie Nothomb', '2025-10-15 14:00:00', 6, 1, 'Salle de conférence A'),
('Nuit de l''Horreur avec Maxime Chattam', '2025-10-31 20:00:00', 12, 2, 'Hall Principal'),
('Atelier écriture Bernard Werber', '2025-11-05 10:00:00', 10, 3, 'Salle Atelier 2');

-- =============================================
-- 6. INSERTION DES VENTES (Historique 2025)
-- =============================================
-- Vente 1 : Client Particulier (Thomas Martin) en Janvier
INSERT INTO Vente (DateVente, ClientID, VendeurID, TotalTTC) VALUES ('2025-01-15 10:30:00', 1, 1, 42.00);
INSERT INTO LigneVente (VenteID, ISBN, Quantite, PrixUnitaire) VALUES 
(SCOPE_IDENTITY(), '9780747532743', 1, 22.00), -- Harry Potter
(SCOPE_IDENTITY(), '9782290032724', 1, 20.50); -- Ensemble c'est tout

-- Vente 2 : Client Pro (Ecole) en Septembre (Rentrée)
INSERT INTO Vente (DateVente, ClientID, VendeurID, TotalTTC) VALUES ('2025-09-02 09:00:00', 5, 4, 150.00);
INSERT INTO LigneVente (VenteID, ISBN, Quantite, PrixUnitaire) VALUES 
(SCOPE_IDENTITY(), '9782070413119', 10, 8.50), -- 10x L'Etranger
(SCOPE_IDENTITY(), '9782253006329', 10, 6.90); -- 10x Germinal

-- Vente 3 : Client Particulier (Dubois Thomas) - Achats multiples pour test historique
INSERT INTO Vente (DateVente, ClientID, VendeurID, TotalTTC) VALUES ('2025-06-10 14:00:00', 3, 2, 11.50);
INSERT INTO LigneVente (VenteID, ISBN, Quantite, PrixUnitaire) VALUES (SCOPE_IDENTITY(), '9782266259270', 1, 11.50);

INSERT INTO Vente (DateVente, ClientID, VendeurID, TotalTTC) VALUES ('2025-07-20 16:00:00', 3, 3, 21.50);
INSERT INTO LigneVente (VenteID, ISBN, Quantite, PrixUnitaire) VALUES (SCOPE_IDENTITY(), '9782226195928', 1, 21.50);

PRINT '>>> Insertion terminée avec succès !';
GO
