# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.local/bin:$PATH
export BDAI=$HOME/projects/bdai
source ~/Documents/dotfiles/scripts/docker/_config/docker_functions.bash

export ROS_DOMAIN_ID=30

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

#Define Widgets
function newTmuxSessionFromFzf() {
  local file=$(fzf --query="$1" +m -e)
  if [ -n "$file" ]; then
    local dir=$(dirname "$file")
    tmux new-session -c "$dir"
  fi
}

function fuzzycd() {
  local file=$(fzf --query="$1" +m)
  if [ -n "$file" ]; then
    cd "$(dirname "$file")" || return
  fi
}

function open_nvim() {
  nvim
}
zle -N open_nvim

function docker_update() {
  /home/lsantos/projects/docker/setup.sh
}
zle -N docker_update

function docker_start() {
  bdai docker start -i ghcr.io/bdaiinstitute/bdaii_ros2_humble_custom:main
}
zle -N docker_start

function clear_screen() {
  clear
  zle reset-prompt
}
zle -N clear_screen

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias tls='tmux ls'
alias tcd='newTmuxSessionFromFzf'
alias fcd=fuzzycd
alias dc='docker compose'
alias dupdate=docker_update
alias dstart=docker_start
alias re='glow README.md'

#Helpful Keybindings
bindkey '^n' open_nvim
bindkey "^p" clear_screen

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init --cmd cd zsh)"
bdcd() { cd "$(bdai cd "$@")" ; }
alias bdai_auth_gcp='gcloud auth login && gcloud auth application-default login'
