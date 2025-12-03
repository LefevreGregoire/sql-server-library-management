# Projet Base de Données librairie

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge) 

> **Conception et Implémentation du Système d'Information d'une librairie**  
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

La librairie modernise son SI. L'objectif de ce projet est de concevoir une base de données relationnelle centrale capable de gérer :
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

![Création BDD](../img/CREATEBDD.png)

---

## 3. Déploiement du Schéma (DDL)

Le déploiement respecte les contraintes d'intégrité référentielle en créant d'abord les tables "parents" avant les tables "enfants".

### 3.1. Tables de Référence (Niveau 1)
Création des entités indépendantes : `Editeur`, `Auteur`, `Rayon`.

![Tables Référence](../img/CREATETABLES.png)

### 3.2. Tables Principales (Niveau 2)
Création des tables `Livre` et `Client`.
> **Note technique** : Mise en place de contraintes `CHECK` (prix positif) et `UNIQUE` (email client) pour garantir la qualité des données dès l'insertion.

![Tables Principales](../img/TABLESPrimaires.png)

### 3.3. Tables Transactionnelles et d'Association (Niveau 3)
Mise en place des relations Many-to-Many (`Livre_Auteur`) et des tables de flux (`Vente`, `Stock`).

![Tables Secondaires](../img/TABLESSecondaires.png)

### 3.4. Validation de la structure
Vérification visuelle dans l'explorateur d'objets SSMS pour confirmer que l'ensemble du schéma `dbo` est conforme au MCD.

![Final Tables](../img/FinalTABLES.png)

---

## 4. Optimisation (Indexation)

Afin de garantir les performances sur les gros volumes (80k références), des index non-clustered ont été ajoutés sur les colonnes de recherche fréquentes (`Titre`, `DateVente`, `NomClient`).

![Index](../img/Index.png)

---

## 5. Tests Fonctionnels & Exploitation (DML)

Un jeu de données complet (simulant l'année 2025) a été injecté. Voici les preuves de fonctionnement des règles de gestion.

### 5.1. Validation des Jointures (Catalogue)
Test de récupération d'un livre avec son auteur et son rayon.

![Test Jointure](../img/TestSCI-FI.png)

### 5.2. Historique Client
**Objectif** : Récupérer tout l'historique d'achat d'un client spécifique.
**Requête** : Jointure `Client` -> `Vente` -> `LigneVente` -> `Livre`.

![Historique Vente](../img/TestHstoriqueVente.png)

### 5.3. Analyse du Chiffre d'Affaires
**Objectif** : Aggrégation des ventes par mois pour suivi comptable.

![CA Mensuel](../img/CA.png)

### 5.4. Gestion des Événements
**Objectif** : Planning des événements futurs (Dédicaces, Rencontres).

![Historique Event](../img/HistoriqueEvent.png)

### 5.5. Top Clients (Bonus)
**Objectif** : Identifier les meilleurs clients (notamment les écoles/pros).

![Bonus Ecole](../img/BonusEcole.png)

### 5.6. Alerte Stock Critique
**Objectif** : Vue automatique remontant les livres sous le seuil d'alerte.

![Seuil Alerte](../img/TestSeuilAlerte.png)

---

## 6. Administration & Sécurité

### 6.1. Vues et Procédures Stockées
Création d'objets pour simplifier l'accès aux données (Vue Stock) et pour les exports (Procédure Export CSV).

![Vues](../img/Vues.png)

![Test Export](../img/TestExport.png)

### 6.2. Sécurité (Rôles)
Implémentation du principe de moindre privilège avec 3 rôles distincts :
*   `Role_Vente`
*   `Role_Gestion_Stock`
*   `Role_Communication`

![Rôles](../img/Rôles.png)

### 6.3. Plan de Sauvegarde
Stratégie mise en place : Sauvegarde Complète (Hebdo) + Différentielle.

![Backups](../img/Backups.png)

---

## 7. Conclusion

Le projet répond à l'ensemble des exigences du cahier des charges "TOUTLA" :
1.  **Intégrité des données** assurée par un schéma normalisé (3FN).
2.  **Performance** garantie par une stratégie d'indexation ciblée.
3.  **Sécurité** gérée nativement via les rôles SQL Server.
4.  **Exploitabilité** facilitée par des vues et procédures stockées dédiées.
