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
        libreadline-dev \
        tree \
        unzip \
        software-properties-common \
        fontconfig \
        libfuse2 \
        ripgrep \
        xclip \
        python3 \
        python3-pip \
        openssh-client \
        net-tools

# Générer les locales
RUN locale-gen en_US.UTF-8

# Installer Node.js 18.x depuis NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Installer des packages npm globaux
RUN npm install -g nodemon

# Définir le répertoire de travail par défaut à /root
WORKDIR /root
RUN mkdir -p projects

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

# Lancer l'installation Mason avec typescript-language-server
RUN nvim --headless -c 'MasonInstall lua-language-server stylua clangd typescript-language-server eslint_d prettier' -c 'q'

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

RUN mkdir -p /root/.config/nvim/lua && \
    printf 'require "nvchad.options"\n\nvim.opt.expandtab = false\nvim.opt.shiftwidth = 4\nvim.opt.tabstop = 4\nvim.opt.list = true\n' > /root/.config/nvim/lua/options.lua

RUN printf 'local M = {}\n' > /root/.config/nvim/lua/chadrc.lua && \
    printf 'M.base46 = {\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '   theme = "tomorrow_night",\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '   hl_override = {\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '      Comment = { italic = true, fg = "#5c6370" },\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '      ["@comment"] = { italic = true, fg = "#5c6370" },\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '      ["Function"] = { bold = true, fg = "#61afef" },\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '      ["String"] = { fg = "#98c379" },\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '      ["Keyword"] = { fg = "#c678dd" },\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '   },\n' >> /root/.config/nvim/lua/chadrc.lua && \
    printf '}\nreturn M\nrequire("options")\n' >> /root/.config/nvim/lua/chadrc.lua

# Définir Zsh comme shell par défaut
CMD ["zsh"]
