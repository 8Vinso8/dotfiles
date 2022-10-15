### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

set fish_greeting

alias vim='nvim'

alias pacsyu='sudo pacman -Syu'
alias mirrors='sudo reflector --country Japan --sort rate --verbose --save /etc/pacman.d/mirrorlist'
alias yaysyu='yay -Syu'

alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

colorscript random

starship init fish | source

