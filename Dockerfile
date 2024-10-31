# Utiliser l'image de base Ubuntu LTS la plus récente
FROM ubuntu:latest

# Mettre à jour les paquets et installer les dépendances essentielles
RUN apt update && apt upgrade -y && \
    apt install -y build-essential valgrind git curl wget software-properties-common

# Installer Neovim (dernière version stable)
RUN add-apt-repository ppa:neovim-ppa/stable -y && \
    apt update && \
    apt install -y neovim

# Installer Ripgrep
RUN apt install -y ripgrep

# Installer NvChad
RUN git clone https://github.com/NvChad/NvChad.git ~/.config/nvim --depth 1

# Installer Nerd Font (par exemple, Hack Nerd Font)
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip && \
    unzip Hack.zip -d ~/.local/share/fonts && \
    fc-cache -fv && \
    rm Hack.zip

# Créer un utilisateur non-root pour le développement
RUN useradd -ms /bin/bash marquis_guest
USER marquis_guest

# Définir le répertoire de travail
WORKDIR /home/marquis_guest

# Exposer le shell
CMD ["/bin/bash"]
