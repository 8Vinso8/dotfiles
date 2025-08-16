function fish_greeting
    return
end

function starship_transient_prompt_func
    starship module character
end

if status is-login
    if test (tty) = /dev/tty1; and uwsm check may-start
        uwsm start niri.desktop
    end
end
if status is-interactive
    alias dotfiles '/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
    starship init fish | source
    enable_transience

    set -gx FZF_DEFAULT_COMMAND "fd --type f --exclude .git --hidden"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND "fd --type d --exclude .git --hidden"
    fzf --fish | source
end
