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
alias mirrors='rate-mirrors --disable-comments-in-file --entry-country=RU --protocol https --per-mirror-timeout 1000 arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
alias update='mirrors && yay'

alias wb='systemctl --user restart waybar.service'

eval "$(starship init zsh)"

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
