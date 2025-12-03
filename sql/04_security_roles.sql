USE TOUTLA_DB;
GO

CREATE ROLE Role_Vente;
CREATE ROLE Role_Gestion_Stock;
CREATE ROLE Role_Communication;

GRANT SELECT, INSERT ON Vente TO Role_Vente;
GRANT SELECT, INSERT ON LigneVente TO Role_Vente;
GRANT SELECT ON Client TO Role_Vente;
GRANT EXECUTE ON GetHistoriqueClient TO Role_Vente;

GRANT SELECT, UPDATE, INSERT ON Stock TO Role_Gestion_Stock;
GRANT SELECT ON Vue_StockCritique TO Role_Gestion_Stock;

GRANT SELECT, INSERT, UPDATE ON Evenement TO Role_Communication;
