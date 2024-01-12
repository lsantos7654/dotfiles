#!/bin/bash

# cd ~/Downloads
# git clone https://github.com/esjeon/krohnkite.git
# cd krohnkite
# make install
# mkdir -p ~/.local/share/kservices5/
# ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
sudo apt install g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev latte-dock
sudo add-apt-repository ppa:touchegg/stable
sudo apt update
sudo apt install touchegg
sudo rm -r ~/.config/touchegg
sudo cp -r ./../.config/touchegg/ ~/.config/
# sudo add-apt-repository ppa:papirus/papirus
# sudo apt update
# sudo apt install qt5-style-kvantum qt5-style-kvantum-themes
# sudo rm -r ~/.config/latte/
# cp -r ./../.config/latte/ ~/.config/
# cp ./Gram/LinuxLGGramScripts/ NEED WORK
# cd ~/Downloads
# git clone https://github.com/EliverLara/Ant.git
# mv ~/Downloads/Ant/kde/Dark ~/Downloads/
# sudo rm -r ~/Downloads/Ant/
# sudo cp -r ~/Downloads/Dark/plasma/desktoptheme/Ant-Dark/ /usr/share/plasma/desktoptheme/
# sudo cp -r ~/Downloads/Dark/plasma/look-and-feel/Ant-Dark/ /usr/share/plasma/look-and-feel/
# sudo cp -r ~/Downloads/Dark/icons/Ant-Dark/ /usr/share/icons/
