#!/bin/bash

sudo apt update
sudo apt install -y git wget

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

sudo apt update
sudo apt install -y neofetch xclip vim tldr fuse python3 python3.11-venv npm zsh curl autojump fzf gpg p7zip-full nodejs eza
sudo npm install -g typescript
sudo apt install libevent-dev libncurses5-dev libncursesw5-dev

tldr -u

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#setup nvim
cd ~/Downloads
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

#setup .zshrc config
rm ~/.zshrc
ln -s ~/Documents/dotfiles/ubuntu_specific/.zshrc ~/.zshrc
ln -s ~/Documents/dotfiles/.p10k.zsh ~/.p10k.zsh

chsh -s $(which zsh)

#install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color

#personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim
