# Utiliser l'image de base Ubuntu LTS la plus récente
FROM ubuntu:latest

# Mettre à jour les paquets et installer les dépendances essentielles
RUN rm -rf /home/ubuntu && \
    apt update && apt upgrade -y && \
    apt install -y build-essential \
    valgrind \
    tree \
    git \
    curl \
    wget \
    unzip \
    software-properties-common \
    fontconfig \
    libfuse2 \
    ripgrep \
    nodejs \
    npm \
    python3 \
    python3-pip

# Installer la dernière version de Neovim
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root /root/nvim && \
    mkdir -p /root/nvim/bin && \
    ln -s /root/nvim/AppRun /root/nvim/bin/nvim && \
    rm nvim.appimage

# Ajouter Neovim au PATH
ENV PATH="/root/nvim/bin/:${PATH}"

# Installer NvChad
RUN git clone https://github.com/NvChad/starter /root/.config/nvim --depth 1 && \
    rm -rf /root/.config/nvim/.git

# Créer un script Lua pour Mason configuration et installation
RUN mkdir -p /root/.config/nvim/lua/custom && \
    echo 'require("mason").setup()' > /root/.config/nvim/lua/custom/mason_setup.lua && \
    echo 'require("mason-lspconfig").setup({ ensure_installed = { "lua-language-server", "stylua" } })' >> /root/.config/nvim/lua/custom/mason_setup.lua && \
    echo 'require("mason-tool-installer").setup { ensure_installed = { "lua-language-server", "stylua" }, auto_update = true, run_on_start = true }' >> /root/.config/nvim/lua/custom/mason_setup.lua

# Installer Mason Tool Installer en tant que plugin personnalisé
RUN mkdir -p /root/.config/nvim/lua/custom/plugins && \
    echo 'return { "WhoIsSethDaniel/mason-tool-installer.nvim" }' > /root/.config/nvim/lua/custom/plugins/mason-tool-installer.lua

# Exécuter Neovim pour charger les plugins et configurer Mason
RUN nvim --headless +'Lazy! sync' +qa

# Lancer l'installation Mason avec un script Lua supplémentaire
RUN echo 'require("mason-tool-installer").install()' > /root/install_mason_tools.lua && \
    nvim --headless -u /root/install_mason_tools.lua +qa && \
    rm /root/install_mason_tools.lua

# Lancer l'installation de lua-language-server et stylua dans Mason
RUN nvim --headless -c 'MasonInstall lua-language-server stylua' -c 'q'

# Installer les polices Hack Nerd
RUN mkdir -p /usr/share/fonts/truetype/hack && \
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -P /tmp && \
    unzip /tmp/Hack.zip -d /usr/share/fonts/truetype/hack && \
    find /usr/share/fonts/truetype/hack -name "*Mono*.ttf" -delete && \
    fc-cache -fv && \
    rm /tmp/Hack.zip

# Personnaliser le prompt pour root
RUN echo 'export PS1="root@marquis_denv:\w> "' >> /root/.bashrc

# Exposer le shell et démarrer dans /home
CMD ["bash", "-c", "cd /home && exec bash"]
