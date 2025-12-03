# Projet BDD - Cas TOUTLA

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge) 

> **Conception et Implémentation du Système d'Information de la librairie TOUTLA**  
> Conception - Exploitation BDD (SQL Server)

---

## Table des Matières
1. [Contexte du Projet](#-contexte-du-projet)f
2. [Architecture de la Base de Données](#-architecture-de-la-base-de-données)
3. [Installation et Déploiement](#-installation-et-déploiement)
4. [Jeu de Données (Scénario 2025)](#-jeu-de-données-scénario-2025)
5. [Fonctionnalités Clés](#-fonctionnalités-clés)
6. [Administration et Sécurité](#-administration-et-sécurité)
7. [Stratégie de Sauvegarde](#-stratégie-de-sauvegarde)

---

## Contexte du Projet

La librairie **TOUTLA**, plus grande librairie indépendante de France, souhaite moderniser son SI. Ce projet vise à concevoir une base de données centralisée sous **Microsoft SQL Server** pour gérer :
*   Le catalogue (Livres, Auteurs, Editeurs, Rayons).
*   Les stocks et les alertes de réassort.
*   Les clients (Particuliers et Professionnels) et leur fidélité.
*   Les ventes et l'historique d'achat.
*   L'organisation d'événements culturels.

---

## Architecture de la Base de Données

Le modèle respecte la **3ème Forme Normale (3FN)**.

### Dictionnaire des Données Simplifié

| Table | Description | Clé Primaire |
| :--- | :--- | :--- |
| `Livre` | Cœur du catalogue (ISBN, Prix, Infos). | `ISBN` |
| `Auteur` | Auteurs des livres. | `AuteurID` |
| `Editeur` | Maisons d'édition. | `EditeurID` |
| `Rayon` | Catégorisation physique des livres. | `RayonID` |
| `Stock` | Gestion des quantités par rayon et emplacement. | `(RayonID, ISBN)` |
| `Client` | Base clients (Type PRO ou PAR). | `ClientID` |
| `Vendeur` | Personnel de la librairie. | `VendeurID` |
| `Vente` | Entête des tickets de caisse. | `VenteID` |
| `LigneVente` | Détail des produits vendus (Prix figé à la vente). | `LigneID` |
| `Evenement` | Planification des rencontres auteurs. | `EventID` |

### Choix Techniques Importants
*   **ISBN :** Stocké en `VARCHAR(13)` (Clé naturelle performante).
*   **Prix :** Utilisation stricte de `DECIMAL(10,2)` pour la précision monétaire.
*   **Dates :** Format universel `AAAAMMJJ` dans les scripts pour éviter les conflits de région.
*   **Intégrité :** Contraintes `CHECK` pour empêcher les stocks ou prix négatifs.

---

## Installation et Déploiement

### Prérequis
*   SQL Server 2019 ou supérieur.
*   SQL Server Management Studio (SSMS).

### Procédure d'installation
Le script SQL fourni (`script_complet.sql`) effectue les actions suivantes :
1.  Création de la base `TOUTLA_DB`.
2.  Création des tables (DDL).
3.  Création des index de performance.
4.  Injection du jeu de données initial.

#### Création de la base TOUTLA_DB

```sql
CREATE DATABASE TOUTLA_DB;
GO

USE TOUTLA_DB;
GO
```

![[CREATEBDD.png]]

#### Création des tables (DDL)

````sql
CREATE TABLE Editeur (
	EditeurID INT IDENTITY(1,1) PRIMARY KEY,
	Nom NVARCHAR(100) NOT NULL,
	Adresse NVARCHAR(255)
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
````

![[CREATETABLES.png]]


![[TABLESPrimaires.png]]

![[TABLESSecondaires.png]]

#### Création des index de performance

![[Index.png]]

---

## Jeu de Données (Scénario 2025)

Pour valider le projet, un jeu de données réaliste a été injecté simulant une année complète d'activité (2025) :
*   **Volumétrie :** Ventes réparties sur 11 mois.
*   **Saisonnalité :** Pics d'activité simulés (Rentrée scolaire, Été, etc).
*   **Réalisme :** Prix et TVA calculés dynamiquement.


---

## Fonctionnalités Clés

Des procédures stockées et des vues facilitent l'exploitation par les applications clientes.

### 1. Historique Client
Permet au vendeur de voir instantanément les achats passés d'un client.
```sql
EXEC GetHistoriqueClient @ClientID = 1;
```

### 2. Export Comptable (CSV)
Génère les lignes comptables formatées pour l'export vers le logiciel de compta.
*   Format : `Date ; MontantHT ; TVA ; MontantTTC ; CodeClient`
```sql
EXEC ExportVentesCSV;
```

### 3. Alertes Stock
Une vue dédiée remonte les livres à commander d'urgence.
```sql
SELECT * FROM Vue_StockCritique;
```

---

## Administration et Sécurité

La sécurité est gérée via une stratégie **RBAC (Role-Based Access Control)** stricte.

### Rôles Définis
| Rôle | Permissions | Description |
| :--- | :--- | :--- |
| `Role_Vente` | `SELECT/INSERT` sur Ventes, Clients | Pour les vendeurs en caisse. |
| `Role_Gestion_Stock` | `FULL` sur Stocks, `SELECT` sur Ventes | Pour les magasiniers. |
| `Role_Communication` | `FULL` sur Événements | Pour les responsables événementiels. |

---

## Stratégie de Sauvegarde

Pour garantir la résilience des données, le plan de maintenance suivant est préconisé :

1.  **Sauvegarde Complète (Full) :** Hebdomadaire (Lundi 02h00).
2.  **Sauvegarde Différentielle (Diff) :** Bi-hebdomadaire (Mercredi/Vendredi 02h00).

```sql
-- Commande type pour l'agent SQL
BACKUP DATABASE TOUTLA_DB 
TO DISK = 'C:\Backups\TOUTLA_Full.bak' 
WITH FORMAT;
```

---


# Projet Base de Données "TOUTLA"

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge) 

> **Conception et Implémentation du Système d'Information de la librairie TOUTLA**  
> Conception - Exploitation BDD (SQL Server)

---

## Table des matières
1. [Contexte et Objectifs](#1-contexte-et-objectifs)
2. [Environnement Technique](#2-environnement-technique)
3. [Déploiement du Schéma (DDL)](#3-déploiement-du-schéma-ddl)
4. [Optimisation (Indexation)](#4-optimisation-indexation)
5. [Tests Fonctionnels & Exploitation (DML)](#5-tests-fonctionnels--exploitation-dml)
6. [Administration & Sécurité](#6-administration--sécurité)
7. [Conclusion](#7-conclusion)

---

## 1. Contexte et Objectifs

La librairie **TOUTLA** modernise son SI. L'objectif de ce projet est de concevoir une base de données relationnelle centrale capable de gérer :
*   Un catalogue de **80 000+ références** (Livres, Auteurs, Editeurs).
*   Des flux transactionnels complexes (Ventes, Commandes Fournisseurs, Réservations).
*   Une gestion fine des stocks par rayon avec seuils d'alerte.
*   Une sécurité basée sur des rôles utilisateurs (Vendeurs, Stocks, Direction).

---

## 2. Environnement Technique

*   **SGBD** : Microsoft SQL Server 2022 (Express Edition 16.x).
*   **Outils** : SQL Server Management Studio (SSMS).
*   **Langage** : Transact-SQL (T-SQL).

**Initialisation du projet :**
Création de la base et définition du contexte d'exécution.

![[CREATEBDD 1.png]]

---

## 3. Déploiement du Schéma (DDL)

Le déploiement respecte les contraintes d'intégrité référentielle en créant d'abord les tables "parents" avant les tables "enfants".

### 3.1. Tables de Référence (Niveau 1)
Création des entités indépendantes : `Editeur`, `Auteur`, `Rayon`.

![[CREATETABLES 1.png]]
### 3.2. Tables Principales (Niveau 2)
Création des tables `Livre` et `Client`.
> **Note technique** : Mise en place de contraintes `CHECK` (prix positif) et `UNIQUE` (email client) pour garantir la qualité des données dès l'insertion.

![[TABLESPrimaires 1.png]]
### 3.3. Tables Transactionnelles et d'Association (Niveau 3)
Mise en place des relations Many-to-Many (`Livre_Auteur`) et des tables de flux (`Vente`, `Stock`).

![[TABLESSecondaires 1.png]]

### 3.4. Validation de la structure
Vérification visuelle dans l'explorateur d'objets SSMS pour confirmer que l'ensemble du schéma `dbo` est conforme au MCD.

![[FinalTABLES.png]]

---

## 4. Optimisation (Indexation)

Afin de garantir les performances sur les gros volumes (80k références), des index non-clustered ont été ajoutés sur les colonnes de recherche fréquentes (`Titre`, `DateVente`, `NomClient`).

![[Index 1.png]]

---

## 5. Tests Fonctionnels & Exploitation (DML)

Un jeu de données complet (simulant l'année 2025) a été injecté. Voici les preuves de fonctionnement des règles de gestion.

### 5.1. Validation des Jointures (Catalogue)
Test de récupération d'un livre avec son auteur et son rayon.

![[TestSCI-FI.png]]
### 5.2. Historique Client
**Objectif** : Récupérer tout l'historique d'achat d'un client spécifique.
**Requête** : Jointure `Client` -> `Vente` -> `LigneVente` -> `Livre`.

![[TestHstoriqueVente.png]]
### 5.3. Analyse du Chiffre d'Affaires
**Objectif** : Aggrégation des ventes par mois pour suivi comptable.

![[CA.png]]
### 5.4. Gestion des Événements
**Objectif** : Planning des événements futurs (Dédicaces, Rencontres).

![[HistoriqueEvent.png]]
### 5.5. Top Clients (Bonus)
**Objectif** : Identifier les meilleurs clients (notamment les écoles/pros).

![[BonusEcole.png]]
### 5.6. Alerte Stock Critique
**Objectif** : Vue automatique remontant les livres sous le seuil d'alerte.

![[TestSeuilAlerte.png]]

---

## 6. Administration & Sécurité

### 6.1. Vues et Procédures Stockées
Création d'objets pour simplifier l'accès aux données (Vue Stock) et pour les exports (Procédure Export CSV).

![[Vues.png]]

![[TestExport.png]]

### 6.2. Sécurité (Rôles)
Implémentation du principe de moindre privilège avec 3 rôles distincts :
*   `Role_Vente`
*   `Role_Gestion_Stock`
*   `Role_Communication`

![[Rôles.png]]

### 6.3. Plan de Sauvegarde
Stratégie mise en place : Sauvegarde Complète (Hebdo) + Différentielle.

![[Backups.png]]

---

## 7. Conclusion

Le projet répond à l'ensemble des exigences du cahier des charges "TOUTLA" :
1.  **Intégrité des données** assurée par un schéma normalisé (3FN).
2.  **Performance** garantie par une stratégie d'indexation ciblée.
3.  **Sécurité** gérée nativement via les rôles SQL Server.
4.  **Exploitabilité** facilitée par des vues et procédures stockées dédiées.

