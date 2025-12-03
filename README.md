# Gestion de Bibliothèque - SQL Server 

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Status](https://img.shields.io/badge/Status-Terminé-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

> **Conception et implémentation de la base de données centrale pour une librairie.**

---

## Description du Projet

Ce projet vise à moderniser le Système d'Information d'une librairie indépendante en France. Il s'agit d'une base de données relationnelle complète sous **Microsoft SQL Server** conçue pour gérer des volumes importants de données (catalogue, ventes, stocks).

### Fonctionnalités principales
*   **Catalogue** : Gestion de 80 000+ références (Livres, Auteurs, Éditeurs).
*   **Stocks** : Suivi par rayon avec alertes de réassort automatiques.
*   **Ventes** : Gestion des clients (Pro/Particuliers), commandes et historique.
*   **Événements** : Planification des rencontres auteurs et dédicaces.
*   **Sécurité** : Gestion des droits via des rôles RBAC (Vendeur, Stock, Com).

---

## Architecture du Repository

Le projet est structuré comme suit :

```text
sql-server-library-management
 ┣ docs
 ┃ ┗ Documentation_Technique.md # Documentation détaillée 
 ┣ sql
 ┃ ┣ 01_create_schema.sql       # Création des tables et contraintes
 ┃ ┣ 02_insert_data.sql         # Jeu de données de test (2025)
 ┃ ┣ 03_procedures_views.sql    # Vues, procédures stockées et fonctions
 ┃ ┣ 04_security_roles.sql      # Configuration des rôles et permissions
 ┃ ┗ 05_backups.sql             # Scripts de sauvegarde (Full/Diff)
 ┣ img                          # Captures d'écran
 ┗ README.md                    # Résumé du projet
```

Installation et Démarrage

Cloner le repo :
    
```bash
git clone https://github.com/LefevreGregoire/sql-server-library-management.git
```
    
Ouvrir SQL Server Management Studio (SSMS).

Exécuter les scripts dans l'ordre (de 01 à 04) :
        Le script 01 crée la base TOUTLA_DB.
        Le script 02 peuple la base avec des données réalistes.
        Le script 03 ajoute la couche logique (Vues/Procédures).
        Le script 04 sécurise les accès.

Exemples d'utilisation

Vérifier le stock critique

```SQL
SELECT * FROM Vue_StockCritique;
```
Obtenir l'historique d'un client

```SQL
EXEC GetHistoriqueClient @ClientID = 1;
```
Exporter les ventes (CSV)

```SQL
EXEC ExportVentesCSV;
```
