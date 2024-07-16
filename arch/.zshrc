# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
export EDITOR=nvim
source ~/Documents/dotfiles/ubuntu/docker_functions.bash
# source ~/Documents/dotfiles/scripts/docker/_config/docker_functions.bash

export SPOTIPY_CLIENT_ID='ee5a68fb8c39415e989da683f6faeaec'
export SPOTIPY_CLIENT_SECRET='20669c7a756e4eb399d032c4deb9a9eb'
export SPOTIPY_REDIRECT_URI='http://localhost:8888/callback'

export ROS_DOMAIN_ID=30
export POWERLEVEL9K_COMMAND_EXECUTION_TIME=true

ZSH_THEME="powerlevel10k/powerlevel10k"

# List of plugins used
plugins=(
  git
  sudo
  zsh-256color
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)
source $ZSH/oh-my-zsh.sh

#Docker Completion
function _docker_all() {
    reply=($(docker ps -a --format '{{.Names}}'))
}
function _docker_on() {
    reply=($(docker ps --format '{{.Names}}'))
}
compctl -K _docker_all drm
compctl -K _docker_on dkill
compctl -K _docker_all drunning 
compctl -K _docker_all dzsh

# Improved autocomplete tmux sessions for tkill
function _tmux_sessions() {
    sessions=("${(@f)$(tmux list-sessions -F '#{session_name}')}")
    _wanted sessions expl 'tmux sessions' compadd -a sessions
}
compdef _tmux_sessions tkill

function fuzzycd() {
  local file=$(find . -type f | fzf --query="$1" +m)
  if [ -n "$file" ]; then
    cd "$(dirname "$file")" || return
  fi
}

#Functions

# Function to search both official repos and AUR
function search_package() {
    local cmd="$1"
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    
    # Search official repos
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$cmd")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$cmd${reset} may be found in the following official packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi

    # Search AUR
    if command -v yay &>/dev/null; then
        local aur_results=$(yay -Fa "$cmd" 2>/dev/null)
        if [[ -n "$aur_results" ]]; then
            printf "${bright}$cmd${reset} may be found in the following AUR packages:\n"
            echo "$aur_results" | while read -r line; do
                printf "${purple}aur/${bright}%s${reset}\n" "$line"
            done
        fi
    fi
}

# Command not found handler
function command_not_found_handler {
    printf 'zsh: command not found: %s\n' "$1"
    search_package "$1"
    return 127
}

# Print workspace file
function pwd_with_file() {
    current_dir=$(pwd)
    current_file=$(basename "$1")
    echo "${current_dir}/${current_file}"
}
zle -N pwd_with_file

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

function open_nvim() {
  nvim
}
zle -N open_nvim

function clear_screen() {
  clear
  zle reset-prompt
}
zle -N clear_screen

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias la='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='tree -h --du ./'
alias tls='tmux ls'
alias n='nvim'
alias tkill='tmux kill-session -t '
alias fcd=fuzzycd
alias re='glow README.md'
alias cpr='rsync --recursive --progress'
alias bat='bat --paging=never'
alias pwf=pwd_with_file 

alias dstart='docker run -it \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--volume /home/santos/project/sandbox:/workspace/ --volume /home/santos/Documents/dotfiles/scripts/docker/_config/:/_config \
--name ros3 \
custom-ros-humble-desktop2:latest'

#Helpful Keybindings
bindkey '^n' open_nvim
bindkey "^p" clear_screen

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init --cmd cd zsh)"
bdcd() { cd "$(bdai cd "$@")" ; }
alias bdai_auth_gcp='gcloud auth login && gcloud auth application-default login'

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec Hyprland
fi
