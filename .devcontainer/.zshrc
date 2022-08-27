export ZSH="/home/vscode/.oh-my-zsh"
ZSH_THEME="cloud"
source $ZSH/oh-my-zsh.sh

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  extract
  colored-man-pages
  sudo
  history
)

# Aliases
alias ll='ls -lsa'
alias s='sudo -s'
alias password='pwgen -n 100 -c -n -s -1'
alias password2='openssl rand -hex 64'
alias docker='ansible-galaxy install -r /tmp/collection/requirements.yml'