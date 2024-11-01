# Utiliser l'image de base Ubuntu LTS la plus récente
FROM ubuntu:latest

# Mettre à jour les paquets et installer les dépendances essentielles
RUN apt update && apt upgrade -y && \
    apt install -y build-essential valgrind git curl wget unzip software-properties-common fontconfig libfuse2 ripgrep nodejs npm

# Créer un utilisateur non-root pour le développement
RUN useradd -ms /bin/bash marquis_guest

# Passer à l'utilisateur non-root
USER marquis_guest
WORKDIR /home/marquis_guest

# Installer la dernière version de Neovim
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root nvim && \
    mkdir -p /home/marquis_guest/nvim/bin && \
    ln -s /home/marquis_guest/nvim/AppRun /home/marquis_guest/nvim/bin/nvim

# Ajouter Neovim au PATH
ENV PATH="/home/marquis_guest/nvim/bin/:${PATH}"

# Installer NvChad (en tant que l'utilisateur non-root)
RUN git clone https://github.com/NvChad/starter /home/marquis_guest/.config/nvim --depth 1 && \
    rm -rf /home/marquis_guest/.config/nvim/.git

# Ajouter la configuration personnalisée pour Mason Tool Installer
RUN mkdir -p /home/marquis_guest/.config/nvim/lua/custom/plugins && \
    echo 'return { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "lua-language-server", "stylua" } } }' > /home/marquis_guest/.config/nvim/lua/custom/plugins/mason-tool-installer.lua

# Exécuter Neovim en mode headless pour installer les plugins avec Lazy
RUN nvim --headless +"Lazy! sync" +qa

# Exécuter Neovim en mode headless pour installer les outils Mason et s'assurer que lua-language-server est installé
RUN nvim --headless -c 'MasonInstallAll' +qa

# Revenir à l'utilisateur root pour installer les polices
USER root

RUN mkdir -p /usr/share/fonts/truetype/hack && \
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -P /tmp && \
    unzip /tmp/Hack.zip -d /usr/share/fonts/truetype/hack && \
    find /usr/share/fonts/truetype/hack -name "*Mono*.ttf" -delete && \
    fc-cache -fv && \
    rm /tmp/Hack.zip

# Revenir à l'utilisateur non-root
USER marquis_guest
WORKDIR /home/marquis_guest

# Personnaliser le prompt pour l'utilisateur marquis_guest
RUN echo 'export PS1="marquis_denv:\w$ "' >> /home/marquis_guest/.bashrc

# Exposer le shell
CMD ["/bin/bash"]
