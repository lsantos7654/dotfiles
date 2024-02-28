#!/bin/bash

apt update
apt install -y git wget curl gpg ninja-build gettext cmake unzip 

mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

apt update
apt install -y build-essential neofetch xclip vim tldr python3 python3.10-venv zsh autojump fzf p7zip-full nodejs eza npm

npm install -g typescript

tldr -u

#setup nvim
tar xvzf ./nvim-linux64.tar.gz
mv ./nvim-linux64/bin/nvim /usr/local/bin/nvim

#personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim

# #setup .zshrc config
# cp ./../.zshrc ~/

# #install oh-my-zsh
# # sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# # chsh -s $(which zsh)
#
# #install zsh plugins
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color
#
