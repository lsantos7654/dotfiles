#!/bin/bash

#TODO
#setup hyprland

#MISC NOTES
#Time sync error??
#sudo timedatectl set-ntp true
# Make directories if they don't exist
# mkdir ~/Documents/
# mkdir ~/Downloads

# sudo pacman -Syu

# sudo pacman -S git base-devel wget unzip neofetch wl-clipboard cliphist vim kitty tldr fuse python3 npm zsh curl fzf p7zip nodejs eza neovim bat

# sudo pacman -S rust gtk3 pango cairo gdk-pixbuf2 glib2 gcc-libs glibc libdbusmenu-gtk3 gtk-layer-shell
# sudo pacman -S pamixer socat jq
# sudo pacman -S pamixer brightnessctl

# # yay install
# git clone https://aur.archlinux.org/yay.git ~/Downloads/yay
# cd ~/Downloads/yay
# makepkg -si
# cd -

# yay -S alsa-tools

# eww install
# git clone https://github.com/elkowar/eww ~/Downloads/eww
# cd ~/Downloads/eww
# cargo build --release --no-default-features --features=wayland
# cd -
# sudo cp ~/Downloads/eww/target/release/eww /usr/local/bin/

# #setup bat
# mkdir ~/.config/bat
# ln -s ~/Documents/dotfiles/.config/bat/config ~/.config/bat/

# tldr -u

# #setup kitty
# rm -r ~/.config/kitty/
# cp -r ~/Documents/dotfiles/.config/kitty/ ~/.config/kitty/
# rm ~/.config/kitty/kitty.conf
# ln -s ~/Documents/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

# #setup fonts
# sudo cp -r ~/Documents/dotfiles/Hack_Fonts /usr/share/fonts/

# #install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# chsh -s $(which zsh)

# #install zsh plugins
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color
# git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#setup .zshrc config
# rm ~/.zshrc
# ln -s ~/Documents/dotfiles/arch/.zshrc ~/.zshrc
# ln -s ~/Documents/dotfiles/arch/.p10k.zsh ~/.p10k.zsh

# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

##personal nvim config
#git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim
