if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.local/bin:$PATH
export BDAI=$HOME/projects/bdai
export EDITOR=nvim
source ~/Documents/dotfiles/ubuntu_specific/docker_functions.bash
# source ~/Documents/dotfiles/scripts/docker/_config/docker_functions.bash

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

# Graphite Completion
_gt_yargs_completions()
{
    local cur_word args type_list

    cur_word="${COMP_WORDS[COMP_CWORD]}"
    args=("${COMP_WORDS[@]}")

    # ask yargs to generate completions.
    type_list=$(gt --get-yargs-completions "${args[@]}")

    COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

    # if no match was found, fall back to filename completion
    if [ ${#COMPREPLY[@]} -eq 0 ]; then
      COMPREPLY=()
    fi

    return 0
}
complete -o bashdefault -o default -F _gt_yargs_completions gt

#Functions

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
alias cat=batcat --paging=never
alias gpu='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glmark2'

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
