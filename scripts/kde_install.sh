#!/bin/bash

#spotify repo link
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

#papirus link
sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main' > /etc/apt/sources.list.d/papirus-ppa.list"
sudo wget -qO /etc/apt/trusted.gpg.d/papirus-ppa.asc 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'

sudo apt-get update

#dependency install
sudo apt-get install -y gcc make autoconf automake pkg-config flex bison libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev libglib2.0-dev libgdk-pixbuf2.0-dev libstartup-notification0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb1-dev libxcb-xkb-dev libxcb-randr0-dev libxcb-xinerama0-dev meson ninja-build libxcb-util-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev libpugixml1v5
sudo apt-get install -y g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev latte-dock

# package installs
sudo apt install kwin-bismuth
sudo apt-get install papirus-icon-theme
sudo apt-get install -y spotify-client
sudo apt install -y qt5-style-kvantum qt5-style-kvantum-themes
sudo apt install kitty git cmake g++ gettext extra-cmake-modules qttools5-dev libkf5configwidgets-dev libkf5globalaccel-dev libkf5notifications-dev kwin-dev

#touchegg repo link
sudo dpkg -i ./packages/touchegg_2.0.17_amd64.deb # Install the package

cd ./packages/tmux-3.4/ || return
./configure && make
sudo make install
cd -

# tpm/tmux config
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm/
sudo rm -r ~/.config/tmux
mkdir ~/.config/tmux
ln -s ~/Documents/dotfiles/.config/tmux/tmux.conf ~/.config/tmux

#toucheg config
sudo rm -r ~/.config/touchegg
cp -r ~/Documents/dotfiles/.config/touchegg ~/.config/
sudo rm ~/.config/touchegg/touchegg.conf
ln -s ~/Documents/dotfiles/.config/touchegg/touchegg.conf ~/.config/touchegg/touchegg.conf

#setup kitty
sudo rm -r ~/.config/kitty
cp -r ~/Documents/dotfiles/.config/kitty/ ~/.config/kitty
sudo rm ~/.config/kitty/kitty.conf
ln -s ~/Documents/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

#setup fonts
sudo cp -r ~/Documents/dotfiles/Hack_Fonts /usr/share/fonts/

#latte-dock install
sudo rm -r ~/.config/latte/
cp -r ~/Documents/dotfiles/.config/latte/ ~/.config/latte

#Ant-Dark install
(cd ~/Downloads && {
	git clone https://github.com/EliverLara/Ant.git
	mv ~/Downloads/Ant/kde/Dark ~/Downloads/
	sudo rm -r ~/Downloads/Ant/
}) || exit
sudo cp -r ~/Downloads/Dark/plasma/desktoptheme/Ant-Dark/ /usr/share/plasma/desktoptheme/
sudo cp -r ~/Downloads/Dark/plasma/look-and-feel/Ant-Dark/ /usr/share/plasma/look-and-feel/
sudo cp -r ~/Downloads/Dark/icons/Ant-Dark/ /usr/share/icons/
sudo cp -r ~/Downloads/Dark/sddm/Ant-Dark/ /usr/share/sddm/themes/
sudo mkdir -p ~/.local/share/aurorae/themes
sudo cp -r ~/Downloads/Dark/aurorae/Ant-Dark/ ~/.local/share/aurorae/themes/

#Rounded Corners Install
(cd ~/Downloads && {
	git clone https://github.com/matinlotfali/KDE-Rounded-Corners
	cd KDE-Rounded-Corners
	mkdir build
	cd build
	cmake .. --install-prefix /usr
	make
	sudo make install
}) || exit
