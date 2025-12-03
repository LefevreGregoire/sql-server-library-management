USE TOUTLA_DB;
GO

-- Vue Stock Critique
CREATE OR ALTER VIEW Vue_StockCritique AS
SELECT L.ISBN, L.Titre, E.Nom AS Editeur, S.Quantite AS Stock_Actuel, L.SeuilAlerte
FROM Stock S
JOIN Livre L ON S.ISBN = L.ISBN
JOIN Editeur E ON L.EditeurID = E.EditeurID
WHERE S.Quantite <= L.SeuilAlerte;
GO

-- Procédure Historique Client
CREATE OR ALTER PROCEDURE GetHistoriqueClient 
    @ClientID INT
AS
BEGIN
    SELECT 
      C.Nom, C.Prenom, V.DateVente, L.Titre, LV.Quantite, LV.PrixUnitaire,
      (LV.Quantite * LV.PrixUnitaire) AS Total_Ligne
    FROM Vente V
    JOIN Client C ON V.ClientID = C.ClientID
    JOIN LigneVente LV ON V.VenteID = LV.VenteID
    JOIN Livre L ON LV.ISBN = L.ISBN
    WHERE C.ClientID = @ClientID
    ORDER BY V.DateVente DESC;
END;
GO

-- Procédure Export CSV
CREATE OR ALTER PROCEDURE ExportVentesCSV AS
BEGIN
  SELECT FORMAT(V.DateVente, 'dd/MM/yyyy') AS [Date],
         CAST(LV.Quantite * LV.PrixUnitaire AS DECIMAL(10,2)) AS [Montant_HT],
         CAST((LV.Quantite * LV.PrixUnitaire) * 0.055 AS DECIMAL(10,2)) AS [TVA_5_5],
         CAST((LV.Quantite * LV.PrixUnitaire) * 1.055 AS DECIMAL(10,2)) AS [Montant_TTC],
         C.ClientID AS [Code_Client],
         LV.ISBN AS [Code_Produit]
  FROM Vente V
  JOIN LigneVente LV ON V.VenteID = LV.VenteID
  JOIN Client C ON V.ClientID = C.ClientID
  ORDER BY V.DateVente ASC, C.ClientID ASC;
END;
GO
