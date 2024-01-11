#!/bin/bash

sudo apt update
sudo apt install -y neofetch xclip vim kitty tldr git fuse python3 python3.11-venv npm zsh curl autojump fzf gpg
# sudo mkdir -p /etc/apt/keyrings
# wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
# echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
# sudo apt update
# sudo apt install -y eza
#tldr -u
#cd ~/Downloads
#wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#chmod +x nvim.appimage
#sudo mv nvim.appimage /usr/local/bin/nvim
# cp -r ./../.config/kitty ~/.config/
# cp ./../.zshrc ~/
sudo cp -r ./../Hack_Fonts /usr/share/fonts/ 
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# chsh -s $(which zsh)
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color
#git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim
