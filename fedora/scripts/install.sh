#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

# Function to run dnf commands with sudo
dnf_install() {
	for package in "$@"; do
		if ! rpm -q "$package" &>/dev/null; then
			sudo dnf install -y "$package"
		else
			echo "Package $package is already installed. Skipping."
		fi
	done
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

# Install initial packages
dnf_install git @development-tools wget unzip

# Install main packages
dnf_install neofetch wl-clipboard vim tldr fuse python3 npm zsh curl fzf gnupg p7zip nodejs exa neovim bat kitty libevent ncurses tmux

# Install additional packages
# Debug: gcc-libs
dnf_install rust gtk3 pango cairo gdk-pixbuf2 glib2 glibc libdbusmenu-gtk3
dnf_install pamixer socat jq brightnessctl alsa-utils

# # Install COPR for glow
# sudo dnf copr enable atim/glow -y
# dnf_install glow

# Install TypeScript
sudo npm install -g typescript

# Update tldr database
tldr -u

# Setup bat
mkdir -p ~/.config/bat
ln -sf ~/Documents/dotfiles/.config/bat/config ~/.config/bat/

# Setup kitty
rm -rf ~/.config/kitty
cp -r ~/Documents/dotfiles/.config/kitty/ ~/.config/kitty/
ln -sf ~/Documents/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Setup fonts
sudo cp -r ~/Documents/dotfiles/Hack_Fonts /usr/share/fonts/

# Install oh-my-zsh
run_cmd sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#chsh -s $(which zsh)

# Install zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/chrissicool/zsh-256color $ZSH_CUSTOM/plugins/zsh-256color

# Setup .zshrc config
ln -sf ~/Documents/dotfiles/fedora/.zshrc ~/.zshrc
ln -sf ~/Documents/dotfiles/fedora/.p10k.zsh ~/.p10k.zsh

# Install zoxide
run_cmd curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Setup personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim

# Setup tpm and tmux config
rm -rf ~/.config/tmux
mkdir -p ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm/
ln -sf ~/Documents/dotfiles/.config/tmux/tmux.conf ~/.config/tmux

echo "Setup complete. Please restart your shell or run 'exec zsh' to apply changes."
