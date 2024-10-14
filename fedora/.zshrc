# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$HOME/.luarocks/bin"
export LUA_PATH="$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;$LUA_PATH"
export LUA_CPATH="$HOME/.luarocks/lib/lua/5.1/?.so;$LUA_CPATH"
export EDITOR=nvim
source ~/Documents/dotfiles/ubuntu_specific/docker_functions.bash
export XDG_CURRENT_DESKTOP=KDE

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

# Print workspace file
function pwd_with_file() {
    current_dir=$(pwd)
    current_file=$(basename "$1")
    echo "${current_dir}/${current_file}"
}
zle -N pwd_with_file


function open_nvim() {
  nvim .
}
zle -N open_nvim

function clear_screen() {
  clear
  zle reset-prompt
}
zle -N clear_screen

function follow_link() {
  builtin cd "$(dirname "$(readlink -f "$1")")"
}
zle -N follow_link

function gcloud_start() {
  gcloud compute instances start $1 --zone $2
}
zle -N gcloud_start

function gcloud_stop() {
  gcloud compute instances stop $1 --zone $2
}
zle -N gcloud_stop

function gcloud_copy() {
  # Get the absolute path of the local file
  local full_path
  full_path=$(realpath "$3")

 # Get the base name of the file or directory
  local base_name
  base_name=$(basename "$3")
  
  
  # Execute the command
  gcloud compute scp --recurse "$full_path" "lsantos_theaiinstitute_com@$1:/home/lsantos_theaiinstitute_com/projects/bdai/recordings/$base_name" --zone="$2" 
}

function gcloud_enter() {
  gcloud compute ssh $1 --ssh-flag="-X" --ssh-flag="-L 8085:localhost:8085" --project=engineering-380817 --zone=$2
}
zle -N gcloud_enter

_gcloud_completions() {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    "1:instances:($(gcloud compute instances list --format='value(name)'))" \
    "2:zones:($(gcloud compute zones list --format='value(name)'))" \
    "3:files:_files" \
}

compdef _gcloud_completions gcloud_start
compdef _gcloud_completions gcloud_stop
compdef _gcloud_completions gcloud_enter
compdef _gcloud_completions gcloud_copy

function bat_tail(){
  local lines=${1:-10}
  local file
  if [[ -f $1 ]]; then
    file=$1
    lines=10
  else
    file=$2
  fi
  batcat --line-range $(expr $(wc -l < "$file") - $lines): "$file"
}
zle -N bat_tail

# Function to run a Docker container with full paths for input and output directories
function docker_script() {
  local input_dir=$(realpath "$1")
  local output_dir=$(realpath "$2")
  local image="$3"

  docker run --rm -d -v "$input_dir:/input" -v "$output_dir:/output" "$image"
}
_docker_script_completions() {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    "1:files:_files" \
    "2:files:_files" \
    "3:zones:($(docker images --format \"{{.Repository}}:{{.Tag}}\"))"
}
compdef _docker_script_completions docker_script
zle -N docker_script

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias la='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='tree -h --du ./'
alias tls='tmux ls'
alias n='nvim'
alias tkill='tmux kill-session -t '
alias re='glow README.md'
alias cpr='rsync --recursive --progress'
alias gls='gcloud compute instances list | grep lsantos'
alias bat='bat --paging=never'
alias ipa="ip -c a"
alias gstart=gcloud_start
alias gstop=gcloud_stop
alias gzsh=gcloud_enter
alias gcp=gcloud_copy
alias fcd=fuzzycd
alias cdl=follow_link
alias tail=bat_tail
alias dscript=docker_script
alias pwf=pwd_with_file 
alias gpu='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'

alias dstart='docker run -it \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--volume /home/santos/project/sandbox:/workspace/ --volume /home/santos/Documents/dotfiles/scripts/docker/_config/:/_config \
--name ros3 \
custom-ros-humble-desktop2:latest'

#Helpful Keybindings
bindkey '^n' open_nvim
bindkey "^p" clear_screen
bindkey "^[h" backward-word
bindkey "^[l" forward-word

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init --cmd cd zsh)"
bdcd() { cd "$(bdai cd "$@")" ; }

# if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
# 	exec Hyprland
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
