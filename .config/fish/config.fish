if status is-interactive
    set -g fish_greeting

    set -gx EDITOR nvim 
    set -gx VISUAL nvim

    set -gx hydro_color_prompt green

    fish_config theme choose catppuccin-mocha

    alias ls "eza --icons --group-directories-first"
    alias ll "eza -lh --icons --group-directories-first"
    alias lt "eza --tree --icons"

    alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

    zoxide init --cmd cd fish | source
end
