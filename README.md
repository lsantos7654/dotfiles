# dotfiles

# Ubuntu Install

sudo apt install kubuntu-desktop
sudo add-apt-repository ppa:kubuntu-ppa/ppa
sudo add-apt-repository ppa:kubuntu-ppa/backports
sudo apt update && sudo apt full-upgrade -y

./scripts/install.sh

./scripts/kde_install.sh

# configure shortcuts
./misc/shortcuts/

# configure rofi
./rofi/config.txt

# configure background
./misc/background/

# configure kwin scripts
./misc/script_info


