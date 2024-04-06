#!/bin/bash

sudo apt update
sudo apt install wget

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
sudo echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

sudo apt update
sudo apt install -y neofetch xclip tldr python3 python3.10-venv zsh autojump fzf p7zip-full nodejs eza npm unzip

sudo npm install -g typescript

tldr -u

#zoxide install
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

#setup nvim
sudo ln -s /_config/nvim-linux64/bin/nvim /usr/local/bin/nvim 
sudo chmod +x /usr/local/bin/nvim

#personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#setup .zshrc config
rm ~/.zshrc
cp /_config/.zshrc ~/
cp /_config/.p10k.zsh ~/

#install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color
