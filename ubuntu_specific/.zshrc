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
source ~/Documents/dotfiles/ubuntu_specific/docker_functions.bash
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

function bdai() {
  # $BDAI/src/bdai/cli/commands/bdai_cmd.py "$@"
  # /workspaces/bdai/core/bdai_cli/src/bdai_cli/commands
  $BDAI/core/bdai_cli/src/bdai_cli/commands/bdai_cmd.py "$@"
  # source $BDAI/projects/_config/misc/setup.zsh 
  # eval "$(register-python-argcomplete3 ros2)"
  # eval "$(register-python-argcomplete3 colcon)"
}

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
alias tkill='tmux kill-session -t '
alias n='nvim'
alias fcd=fuzzycd
alias re='glow README.md'

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
