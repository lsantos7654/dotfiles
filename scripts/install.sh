# #!/bin/bash
#
# set -e # Exit immediately if a command exits with a non-zero status.
#
# # Function to run apt commands with sudo
# apt_install() {
# 	sudo apt update
# 	sudo apt install -y "$@"
# }
#
# # Function to run commands with error handling
# run_cmd() {
# 	if ! "$@"; then
# 		echo "Error: Command failed: $*" >&2
# 		return 1
# 	fi
# }
#
# # Install initial packages
# apt_install git wget
#
# # Setup eza repository
# sudo mkdir -p /etc/apt/keyrings
# run_cmd wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
# echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
#
# # Install main packages
# apt_install neofetch xclip vim tldr fuse python3 python3-venv npm zsh curl autojump fzf gpg p7zip-full nodejs eza unzip autoconf automake libtool build-essential libevent-dev libncurses5-dev libncursesw5-dev
#
# # Install TypeScript
# sudo npm install -g typescript
#
# # Update tldr database
# tldr -u
#
# # Install oh-my-zsh
# run_cmd sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#
# # Install zoxide
# run_cmd curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
#
# # Setup nvim
# (
# 	cd ~/Downloads
# 	wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
# 	chmod +x nvim.appimage
# 	sudo mv nvim.appimage /usr/local/bin/nvim
# )
#
# # Setup .zshrc config
# ln -sf ~/Documents/dotfiles/ubuntu_specific/.zshrc ~/.zshrc
# ln -sf ~/Documents/dotfiles/.p10k.zsh ~/.p10k.zsh

# Install and setup tmux
(
	cd ~/Documents/dotfiles/scripts/packages/tmux-3.4/ || exit
	autoreconf -fiv
	./configure && make
	sudo make install
)

# Setup tpm and tmux config
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm/
rm -rf ~/.config/tmux
mkdir -p ~/.config/tmux
ln -sf ~/Documents/dotfiles/.config/tmux/tmux.conf ~/.config/tmux

# # Install zsh plugins
# ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
# git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# git clone https://github.com/chrissicool/zsh-256color $ZSH_CUSTOM/plugins/zsh-256color
#
# # Setup personal nvim config
# git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim
#
# exec zsh
