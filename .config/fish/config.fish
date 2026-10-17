set -gx EDITOR nvim
set -gx VISUAL nvim

if status is-interactive
    set -g fish_greeting

    # Настройка промпта Hydro
    set -g hydro_symbol_prompt "❯"
    set -gx hydro_color_prompt green

    fish_config theme choose catppuccin-mocha

    # Поиск файлов fzf.fish в скрытых папках (дотфайлы), исключая .git
    set -g fzf_fd_opts --hidden --exclude=.git

    # Цветовая палитра Catppuccin Mocha для FZF
    set -gx FZF_DEFAULT_OPTS " \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --multi"

    alias ls "eza --icons --group-directories-first"
    alias ll "eza -lh --icons --group-directories-first"
    alias lt "eza --tree --icons"

    alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

    zoxide init --cmd cd fish | source
end
