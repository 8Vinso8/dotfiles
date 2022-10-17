set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

set fish_greeting

alias vim='nvim'

alias pacsyu='sudo pacman -Syu'
alias mirrors='sudo reflector --country Japan --sort rate --verbose --save /etc/pacman.d/mirrorlist'
alias yaysua='yay -Sua --noconfirm'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

alias suspend="sudo systemctl suspend"
alias hibernate="sudo systemctl hibernate"

alias syncDocs="/usr/bin/rclone copy --update --verbose --transfers 30 --checkers 8 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s "/home/vinso/Документы" "google-drive:Конспекты""

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


colorscript random

starship init fish | source

