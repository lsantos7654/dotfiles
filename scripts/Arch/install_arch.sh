#!/bin/bash

sudo pacman -Syu

sudo pacman -S git base-devel wget unzip neofetch xclip vim kitty tldr fuse python3 npm zsh curl fzf p7zip nodejs eza

# yay install
cd ~/Downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd -

yay -S autojump

tldr -u

#setup nvim
cd ~/Downloads
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
cd -

#setup kitty
cp -r ./../../.config/kitty ~/.config/

#setup .zshrc config
cp ./../../.zshrc ~/

#setup fonts
sudo cp -r ./../../Hack_Fonts /usr/share/fonts/ 

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

#install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color

#personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim
