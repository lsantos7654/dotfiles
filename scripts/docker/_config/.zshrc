# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin
export PATH"$PATH:/opt/nvim-linux64/bin"
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.local/bin:$PATH
export GOPATH=$HOME/go
export BDAI=$HOME/Projects/bdai

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

#Define Widgets
function newTmuxSessionFromFzf() {
  local file=$(fzf --query="$1" +m -e)
  if [ -n "$file" ]; then
    local dir=$(dirname "$file")
    tmux new-session -c "$dir"
  fi
}
#Docker Completeion for bash
# _dkill_complete() {
#     local cur=${COMP_WORDS[COMP_CWORD]}
#     local running_containers=$(docker ps --format '{{.Names}}')
#     COMPREPLY=($(compgen -W "${running_containers}" -- ${cur}))
# }
# complete -F _dkill_complete dkill

#Docker Completion
_dkill_complete() {
    reply=($(docker ps --format '{{.Names}}'))
}
compctl -K _dkill_complete dkill

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
alias tl='tmux ls'
alias ff='newTmuxSessionFromFzf'
alias fd=fuzzycd
alias dc='docker compose'

#Helpful Keybindings
bindkey '^n' open_nvim
bindkey "^p" clear_screen

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init --cmd cd zsh)"
