#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

# Function to run pacman commands with sudo
pacman_install() {
	sudo pacman -Syu --noconfirm "$@"
}

# Function to run commands with error handling
run_cmd() {
	if ! "$@"; then
		echo "Error: Command failed: $*" >&2
		return 1
	fi
}

# Install yay if not already installed
if ! command -v yay &>/dev/null; then
	git clone https://aur.archlinux.org/yay.git ~/Downloads/yay
	(cd ~/Downloads/yay && makepkg -si --noconfirm)
	rm -rf ~/Downloads/yay
fi

# Install dependencies and packages
pacman_install gcc make autoconf automake pkg-config flex bison pango cairo glib2 gdk-pixbuf2 startup-notification libxkbcommon libxcb xcb-util-wm xcb-util-cursor pugixml qt5-base qt5-svg qt5-x11extras kwindowsystem qt5-tools papirus-icon-theme kitty git cmake gettext extra-cmake-modules kconfig kglobalaccel knotifications kwin

# Install AUR packages
yay -S --noconfirm spotify touchegg kvantum-qt5

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

echo "KDE setup complete. Please restart your session to apply all changes."
