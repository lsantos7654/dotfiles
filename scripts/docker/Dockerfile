FROM osrf/ros:humble-desktop

# Customize the image
# For example, install additional dependencies

# RUN apt update && upgrade
RUN apt-get update && apt-get install -y
RUN apt install -y git wget

RUN mkdir -p /etc/apt/keyrings
RUN wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
RUN chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

RUN apt update
RUN apt install -y fuse neofetch xclip tldr python3 python3.10-venv zsh autojump fzf p7zip-full eza npm

RUN apt-get remove -y libnode-dev
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && apt-get install -y nodejs

RUN npm install -g typescript

# RUN tldr -u

#zoxide install
RUN curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

#setup nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN rm -rf /opt/nvim
RUN tar -C /opt -xzf nvim-linux64.tar.gz

#personal nvim config
RUN git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim

#install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#setup .zshrc config
RUN rm ~/.zshrc
COPY _config/.zshrc /root/.zshrc 
COPY _config/.p10k.zsh /root/.p10k.zsh

#fzf dependency?
COPY _config/key-bindings.zsh /usr/share/doc/fzf/examples/
# COPY ./key-bindings.zsh /usr/share/doc/fzf/examples/

#install zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color
# Set up your workspace or any other custom setup you need

RUN apt install unzip
RUN /opt/nvim-linux64/bin/nvim --headless -c 'Lazy sync' & sleep 30; kill $!

