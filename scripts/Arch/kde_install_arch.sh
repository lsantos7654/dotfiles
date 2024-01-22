#!/bin/bash

# sudo pacman -Syu

#spotify install
# sudo pacman -S spotify-launcher

#touchegg install
# sudo pacman -S touchegg
# sudo systemctl enable touchegg.service
# sudo systemctl start touchegg

#KDE-Rounded-Corners dependency install
# sudo pacman -S git cmake extra-cmake-modules base-devel
# yay -S qt5-tools

#toucheg config
# sudo rm -r ~/.config/touchegg
# sudo cp -r ./../.config/touchegg/ ~/.config/

#Krohnkite install
# cp ./krohnkite-0.8.1.kwinscript ~/Downloads/
# cd ~/Downloads/
# plasmapkg2 -t kwinscript -i krohnkite-0.8.1.kwinscript
# plasmapkg2 -t kwinscript -u krohnkite-0.8.1.kwinscript
# mkdir -p ~/.local/share/kservices5/
# ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
# cd -

# #latte-dock install
# sudo pacman -S latte-dock
sudo rm -r ~/.config/latte/
cp -r ./../../.config/latte/ ~/.config/
#
# #rofi install
# sudo pacman -S rofi
#
# #rofi theme setup
# cd ~/Downloads
# git clone --depth=1 https://github.com/adi1090x/rofi.git
# cd rofi
# chmod +x setup.sh
# ./setup.sh
# cd -
#
# #Ant-Dark install
# cd ~/Downloads
# git clone https://github.com/EliverLara/Ant.git
# mv ~/Downloads/Ant/kde/Dark ~/Downloads/
# sudo rm -r ~/Downloads/Ant/
# sudo cp -r ~/Downloads/Dark/plasma/desktoptheme/Ant-Dark/ /usr/share/plasma/desktoptheme/
# sudo cp -r ~/Downloads/Dark/plasma/look-and-feel/Ant-Dark/ /usr/share/plasma/look-and-feel/
# sudo cp -r ~/Downloads/Dark/icons/Ant-Dark/ /usr/share/icons/
# sudo cp -r ~/Downloads/Dark/sddm/Ant-Dark/ /usr/share/sddm/themes/
# mkdir -p ~/.local/share/aurorae/theme/
# sudo cp -r ~/Downloads/Dark/aurorae/Ant-Dark ~/.local/share/aurorae/themes/
# cd -
#
# #Rounded Corners Install
# cd ~/Downloads
# git clone https://github.com/matinlotfali/KDE-Rounded-Corners
# cd KDE-Rounded-Corners
# mkdir build
# cd build
# cmake .. --install-prefix /usr
# make
# sudo make install
# cd -
