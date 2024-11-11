#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Function to run brew commands
brew_install() {
    for package in "$@"; do
        if ! brew list "$package" &>/dev/null; then
            brew install "$package"
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

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
brew update
brew upgrade

# Install initial packages
brew_install git wget unzip

# Install main packages
brew_install neofetch clipboard vim tldr python3 npm zsh curl fzf gnupg p7zip node eza neovim bat kitty tmux

# Install additional packages
brew_install rust gtk+3 pango cairo gdk-pixbuf glib
brew_install socat jq

# Install glow
brew_install glow

# Install TypeScript
npm install -g typescript

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
cp -r ~/Documents/dotfiles/Hack_Fonts ~/Library/Fonts/

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
brew_install zoxide

# Setup personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim

# Setup tpm and tmux config
rm -rf ~/.config/tmux
mkdir -p ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm/
ln -sf ~/Documents/dotfiles/.config/tmux/tmux.conf ~/.config/tmux

echo "Setup complete. Please restart your shell or run 'exec zsh' to apply changes."
