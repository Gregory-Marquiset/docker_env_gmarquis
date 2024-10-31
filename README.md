# Marquis Development Environment (marquis_denv) 🛠️

Bienvenue dans **marquis_denv** ! Ce projet est un environnement de développement Docker personnalisé, conçu pour simplifier la mise en place d'un environnement de travail cohérent où que vous soyez.

## 👨‍💼 Présentation du projet

**marquis_denv** fournit un environnement de développement basé sur **Ubuntu LTS**, préconfiguré avec des outils et éditeurs nécessaires pour le développement logiciel, en particulier pour les langages **C** et **C++**.

### Fonctionnalités incluses :

- 🫠 **Neovim** (avec NvChad) comme éditeur de code principal
- 🛠 **Build-essential** pour la compilation de code
- 🔢 **Valgrind** pour le débogage de la mémoire
- 📁 **Ripgrep** pour des recherches de code rapides et efficaces
- 🌐 **Nerd Fonts** pour une interface plus agréable dans Neovim
- 💻 Création d'un utilisateur **non-root** pour la sécurité

## 📒 Pré-requis

- **Docker** : Assurez-vous d'avoir Docker installé sur votre système.

## 🛠 Installation

1. Clonez le dépôt sur votre machine :
   ```bash
   git clone https://github.com/Gregory-Marquiset/marquis_denv.git
   ```
2. Rendez-vous dans le répertoire du projet :
   ```bash
   cd marquis_denv
   ```
3. Construisez l'image Docker :
   ```bash
   docker build -t marquis_denv .
   ```

## 🌟 Utilisation

Pour lancer le conteneur :
```bash
docker run -it marquis_denv
```
Cela vous connectera au shell de l'utilisateur **marquis_guest** dans l'environnement de développement pré-configuré.

## 🛡️ Outils inclus

- **Neovim** avec **NvChad** pré-installé pour une expérience de développement moderne et personnalisable.
- **Ripgrep** pour des recherches de texte rapides.
- **Valgrind** pour vérifier les fuites de mémoire dans vos programmes C/C++.
- **Nerd Fonts** (Hack Nerd Font) pour une meilleure expérience visuelle dans Neovim.

## 🛠 Customisation de l'environnement
L'éditeur **Neovim** est configuré avec **NvChad**, une distribution moderne qui offre de nombreuses fonctionnalités adaptées au développement. N'hésitez pas à personnaliser la configuration de Neovim (à l'emplacement `~/.config/nvim`) selon vos besoins.

## 🌐 Liens utiles

- [Dépôt GitHub](https://github.com/Gregory-Marquiset/marquis_denv) — Pour obtenir le code source et suivre les mises à jour du projet.
- [Docker Documentation](https://docs.docker.com/get-started/) — Pour installer Docker si ce n'est pas déjà fait.

## 🛍️ Licence
Ce projet est sous licence **MIT**. Consultez le fichier `LICENSE` pour plus de détails.

---
Merci d'utiliser **marquis_denv** ! Si vous avez des suggestions d'amélioration ou des problèmes, n'hésitez pas à me contacter directement via GitHub. 👋🎉
