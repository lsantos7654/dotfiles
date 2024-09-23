#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

# Function to run dnf commands with sudo
dnf_install() {
  sudo dnf install -y "$@"
}

# Function to run commands with error handling
run_cmd() {
  if ! "$@"; then
    echo "Error: Command failed: $*" >&2
    return 1
  fi
}

# Update system
sudo dnf upgrade -y

# Install dependencies and packages
dnf_install gcc make autoconf automake pkg-config flex bison pango cairo glib2 gdk-pixbuf2 startup-notification libxkbcommon libxcb xcb-util-wm xcb-util-cursor pugixml qt5-qtbase qt5-qtsvg qt5-qtx11extras kf5-kwindowsystem qt5-qttools papirus-icon-theme cmake gettext extra-cmake-modules kf5-kconfig kf5-kglobalaccel kf5-knotifications kwin

# Install Kvantum
dnf_install kvantum

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
