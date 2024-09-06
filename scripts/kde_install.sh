#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

# Function to run apt commands with sudo
apt_install() {
	sudo apt-get update
	sudo apt-get install -y "$@"
}

# Function to run commands with error handling
run_cmd() {
	if ! "$@"; then
		echo "Error: Command failed: $*" >&2
		return 1
	fi
}

# Add repositories
run_cmd curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main' > /etc/apt/sources.list.d/papirus-ppa.list"
run_cmd sudo wget -qO /etc/apt/trusted.gpg.d/papirus-ppa.asc 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'

# Install dependencies and packages
apt_install gcc make autoconf automake pkg-config flex bison libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev libglib2.0-dev libgdk-pixbuf2.0-dev libstartup-notification0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb1-dev libxcb-xkb-dev libxcb-randr0-dev libxcb-xinerama0-dev meson ninja-build libxcb-util-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev libpugixml1v5 g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev latte-dock kwin-bismuth papirus-icon-theme spotify-client qt5-style-kvantum qt5-style-kvantum-themes kitty git cmake gettext extra-cmake-modules qttools5-dev libkf5configwidgets-dev libkf5globalaccel-dev libkf5notifications-dev kwin-dev

# Install Touchegg
sudo dpkg -i ./packages/touchegg_2.0.17_amd64.deb

# Setup configs
setup_config() {
	local config_dir=$1
	local config_file=$2
	rm -rf ~/.config/$config_dir
	cp -r ~/Documents/dotfiles/.config/$config_dir ~/.config/
	rm ~/.config/$config_dir/$config_file
	ln -sf ~/Documents/dotfiles/.config/$config_dir/$config_file ~/.config/$config_dir/$config_file
}

setup_config touchegg touchegg.conf
setup_config kitty kitty.conf

# Setup fonts
sudo cp -r ~/Documents/dotfiles/Hack_Fonts /usr/share/fonts/

# Setup latte-dock
rm -rf ~/.config/latte/
cp -r ~/Documents/dotfiles/.config/latte/ ~/.config/latte

# Install Ant-Dark theme
(
	cd ~/Downloads || exit
	git clone https://github.com/EliverLara/Ant.git
	mv Ant/kde/Dark ./
	rm -rf Ant
	sudo cp -r Dark/plasma/desktoptheme/Ant-Dark/ /usr/share/plasma/desktoptheme/
	sudo cp -r Dark/plasma/look-and-feel/Ant-Dark/ /usr/share/plasma/look-and-feel/
	sudo cp -r Dark/icons/Ant-Dark/ /usr/share/icons/
	sudo cp -r Dark/sddm/Ant-Dark/ /usr/share/sddm/themes/
	mkdir -p ~/.local/share/aurorae/themes
	cp -r Dark/aurorae/Ant-Dark/ ~/.local/share/aurorae/themes/
)

# Install Rounded Corners
sudo dpkg -i ~/Documents/dotfiles/scripts/packages/kwin4_effect_shapecorners_kubuntu2204.deb

echo "KDE setup complete. Please restart your session to apply all changes."
