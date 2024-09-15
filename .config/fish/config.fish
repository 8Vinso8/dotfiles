set -g fish_greeting

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

if test (tty) = "/dev/tty1"
    exec Hyprland
end

if test "$TERM" = "xterm-kitty"
    alias ssh="kitty +kitten ssh"
end
starship init fish | source
