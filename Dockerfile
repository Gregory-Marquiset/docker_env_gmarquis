# Utiliser l'image de base Ubuntu LTS la plus récente
FROM ubuntu:latest

# Définir les variables d'environnement pour la locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    HOSTNAME="root"

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    zsh \
    git \
    curl \
    wget \
    fonts-powerline \
    locales \
    build-essential \
    valgrind \
    tree \
    unzip \
    software-properties-common \
    fontconfig \
    libfuse2 \
    ripgrep \
    xclip \
    nodejs \
    npm \
    python3 \
    python3-pip \
    openssh-client

# Générer les locales
RUN locale-gen en_US.UTF-8

# Définir le répertoire de travail par défaut à /root
WORKDIR /root

# Installer Oh My Zsh pour l'utilisateur root
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' /root/.zshrc

# Installer la dernière version de Neovim
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root /root/nvim && \
    ln -s /root/nvim/AppRun /usr/bin/nvim && \
    rm nvim.appimage

# Ajouter Neovim au PATH
ENV PATH="/root/nvim/bin/:${PATH}"

# Installer NvChad
RUN git clone https://github.com/NvChad/starter /root/.config/nvim --depth 1 && \
    rm -rf /root/.config/nvim/.git

# Exécuter Neovim pour charger les plugins et configurer Mason
RUN nvim --headless +'Lazy! sync' +qa

# Lancer l'installation Mason avec un script Lua supplémentaire
RUN nvim --headless -c 'MasonInstall lua-language-server stylua clangd' -c 'q'

# Installer les polices Hack Nerd
RUN mkdir -p /usr/share/fonts/truetype/hack && \
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -P /tmp && \
    unzip -qq /tmp/Hack.zip -d /usr/share/fonts/truetype/hack && \
    find /usr/share/fonts/truetype/hack -name "*Windows Compatible.ttf" -delete && \
    find /usr/share/fonts/truetype/hack -name "*Mono.ttf" -delete && \
    fc-cache -fv && \
    rm /tmp/Hack.zip

# Supprimer le répertoire /home s'il existe
RUN rm -rf /home

# Définir Zsh comme shell par défaut
CMD ["zsh"]
