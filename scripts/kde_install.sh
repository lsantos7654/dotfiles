#!/bin/bash

#spotify repo link
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

#touchegg repo link
sudo add-apt-repository ppa:touchegg/stable

#papirus link
sudo add-apt-repository ppa:papirus/papirus

sudo apt-get update

#dependency install
sudo apt-get install -y gcc make autoconf automake pkg-config flex bison libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev libglib2.0-dev libgdk-pixbuf2.0-dev libstartup-notification0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb1-dev libxcb-xkb-dev libxcb-randr0-dev libxcb-xinerama0-dev meson ninja-build libxcb-util-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev
sudo apt-get install -y spotify-client
sudo apt install -y touchegg
sudo apt-get install -y g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev latte-dock
sudo apt install -y qt5-style-kvantum qt5-style-kvantum-themes

#toucheg config
sudo rm -r ~/.config/touchegg
sudo cp -r ./../.config/touchegg/ ~/.config/


#Krohnkite install
git clone https://github.com/esjeon/krohnkite.git ~/Downloads/
cd ~/Downloads/krohnkite
make install
mkdir -p ~/.local/share/kservices5/
ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
cd -

#latte-dock install
sudo rm -r ~/.config/latte/
cp -r ./../.config/latte/ ~/.config/

#rofi install
cp ../rofi/rofi-1.7.5.tar.gz ~/Downloads/
cd ~/Downloads
tar xvf rofi-1.7.5.tar.gz
cd rofi-1.7.5
meson setup build
ninja -C build
ninja -C build install
cd -

#rofi theme setup
cd ~/Downloads
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh
cd -

#Ant-Dark install
cd ~/Downloads
git clone https://github.com/EliverLara/Ant.git
mv ~/Downloads/Ant/kde/Dark ~/Downloads/
sudo rm -r ~/Downloads/Ant/
sudo cp -r ~/Downloads/Dark/plasma/desktoptheme/Ant-Dark/ /usr/share/plasma/desktoptheme/
sudo cp -r ~/Downloads/Dark/plasma/look-and-feel/Ant-Dark/ /usr/share/plasma/look-and-feel/
sudo cp -r ~/Downloads/Dark/icons/Ant-Dark/ /usr/share/icons/
sudo cp -r ~/Downloads/Dark/sddm/Ant-Dark/ /usr/share/sddm/themes/
sudo cp -r ~/Downloads/Dark/aurorae/Ant-Dark/ ~/.local/share/aurorae/themes/
