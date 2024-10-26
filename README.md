# Docker Environnement de Développement

Ce projet Docker fournit un environnement de développement portable, équipé d'outils pour la programmation en C/C++ et en Node.js, avec un éditeur de code NeoVim configuré pour des fonctionnalités avancées.

## 🛠 Fonctionnalités Principales

- **NeoVim** avec autocomplétion, arborescence des fichiers, et gestion Git.
- Repliement visuel des fonctions et surlignage automatique des occurrences d’un mot sélectionné.
- Gestion Git intégrée pour commit, push, et changements de branche.
- **Tests automatisés** via **vim-test** pour exécuter les tests en C/C++ et Node.js.
- Mise à jour automatique du Docker si le fichier Docker ou les configurations ont été modifiées.

## 🚀 Installation et Lancement

### Prérequis

- **Docker** et **Docker Compose** doivent être installés sur votre machine.

### Installation

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/ton-utilisateur/docker-environnement-dev.git
   cd docker-environnement-dev
