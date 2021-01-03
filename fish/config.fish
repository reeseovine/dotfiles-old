set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_color_scheme terminal2-light
set -g theme_nerd_fonts yes

fenv source ~/.profile

# import bash aliases
if test -e ~/.bash_aliases
    source ~/.bash_aliases
end

# Load autojump
source /usr/share/autojump/autojump.fish
