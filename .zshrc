source $HOME/completion.zsh
source $HOME/ssh.zsh
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep
bindkey -e
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias нфн='yay'
alias dblock='sudo rm /var/lib/pacman/db.lck'
eval "$(starship init zsh)"