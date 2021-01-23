# stuff for all shells
if test -e ~/.profile
	bass source ~/.profile
end
if test -e ~/.bash_aliases
    bass source ~/.bash_aliases
end

# bobthefish theme variables
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal2-light
set -g theme_nerd_fonts yes

# Load autojump
source /usr/share/autojump/autojump.fish
