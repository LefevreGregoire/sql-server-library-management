CREATE DATABASE TOUTLA_DB;
GO
USE TOUTLA_DB;
GO

-- Tables de référence
CREATE TABLE Editeur (
    EditeurID INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(100) NOT NULL,
    Adresse NVARCHAR(255),
    ContactEmail NVARCHAR(100)
);

CREATE TABLE Auteur (
    AuteurID INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(100) NOT NULL,
    Prenom NVARCHAR(100),
    Biographie NVARCHAR(MAX)
);

CREATE TABLE Rayon (
    RayonID INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);

-- Tables principales
CREATE TABLE Livre (
    ISBN VARCHAR(13) PRIMARY KEY,
    Titre NVARCHAR(200) NOT NULL,
    Resume NVARCHAR(MAX),
    PrixHT DECIMAL(10, 2) NOT NULL,
    DateParution DATE,
    Langue NVARCHAR(50) DEFAULT 'Français',
    Format NVARCHAR(50),
    SeuilAlerte INT DEFAULT 5,
    EditeurID INT NOT NULL,
    RayonID_Principal INT NOT NULL,
    CONSTRAINT FK_Livre_Editeur FOREIGN KEY (EditeurID) REFERENCES Editeur(EditeurID),
    CONSTRAINT FK_Livre_Rayon FOREIGN KEY (RayonID_Principal) REFERENCES Rayon(RayonID),
    CONSTRAINT CK_Prix_Positif CHECK (PrixHT >= 0)
);

CREATE TABLE Client (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(100) NOT NULL,
    Prenom NVARCHAR(100),
    TypeClient CHAR(13) NOT NULL, -- 'Particulier' or 'Professionnel'
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Telephone VARCHAR(20),
    NumFidelite VARCHAR(20),
    RemisePro DECIMAL(4, 2) DEFAULT 0,
    DateCreation DATETIME DEFAULT GETDATE(),
    Siret VARCHAR(50),
    Adresse NVARCHAR(255),
    CodePostal VARCHAR(10),
    Ville NVARCHAR(100),
    CarteFidelite BIT DEFAULT 0
);

CREATE TABLE Vendeur (
    VendeurID INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(100) NOT NULL,
    Prenom NVARCHAR(100),
    Email NVARCHAR(150),
    IdRayonSpecialite INT,
    CONSTRAINT FK_Vendeur_Rayon FOREIGN KEY (IdRayonSpecialite) REFERENCES Rayon(RayonID)
);

-- Tables de liaison et transactionnelles
CREATE TABLE Livre_Auteur (
    ISBN VARCHAR(13) NOT NULL,
    AuteurID INT NOT NULL,
    PRIMARY KEY (ISBN, AuteurID),
    CONSTRAINT FK_LA_Livre FOREIGN KEY (ISBN) REFERENCES Livre(ISBN),
    CONSTRAINT FK_LA_Auteur FOREIGN KEY (AuteurID) REFERENCES Auteur(AuteurID)
);

CREATE TABLE Stock (
    RayonID INT NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    Quantite INT NOT NULL DEFAULT 0,
    Emplacement VARCHAR(50),
    PRIMARY KEY (RayonID, ISBN),
    CONSTRAINT FK_Stock_Rayon FOREIGN KEY (RayonID) REFERENCES Rayon(RayonID),
    CONSTRAINT FK_Stock_Livre FOREIGN KEY (ISBN) REFERENCES Livre(ISBN),
    CONSTRAINT CK_Stock_Positif CHECK (Quantite >= 0)
);

CREATE TABLE Evenement (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(200) NOT NULL,
    DateEvent DATETIME NOT NULL,
    Lieu NVARCHAR(100),
    AuteurInviteID INT,
    ResponsableID INT,
    CONSTRAINT FK_Event_Auteur FOREIGN KEY (AuteurInviteID) REFERENCES Auteur(AuteurID),
    CONSTRAINT FK_Event_Vendeur FOREIGN KEY (ResponsableID) REFERENCES Vendeur(VendeurID)
);

CREATE TABLE Vente (
    VenteID INT IDENTITY(1,1) PRIMARY KEY,
    DateVente DATETIME DEFAULT GETDATE(),
    ClientID INT,
    VendeurID INT NOT NULL,
    Statut NVARCHAR(20) DEFAULT 'Terminée',
    TotalTTC DECIMAL(10,2),
    CONSTRAINT FK_Vente_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    CONSTRAINT FK_Vente_Vendeur FOREIGN KEY (VendeurID) REFERENCES Vendeur(VendeurID)
);

CREATE TABLE LigneVente (
    LigneID INT IDENTITY(1,1) PRIMARY KEY,
    VenteID INT NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    Quantite INT NOT NULL,
    PrixUnitaire DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_LV_Vente FOREIGN KEY (VenteID) REFERENCES Vente(VenteID),
    CONSTRAINT FK_LV_Livre FOREIGN KEY (ISBN) REFERENCES Livre(ISBN)
);

-- Index
CREATE INDEX IX_Livre_Titre ON Livre(Titre);
CREATE INDEX IX_Stock_ISBN ON Stock(ISBN);
CREATE INDEX IX_Vente_Date ON Vente(DateVente);
CREATE INDEX IX_Client_Nom ON Client(Nom);
CREATE INDEX IX_LigneVente_Vente_ISBN ON LigneVente(VenteID, ISBN);
