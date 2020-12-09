set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_color_scheme terminal-light

fenv source ~/.profile

# import bash aliases
if test -e ~/.bash_aliases
    fenv source ~/.bash_aliases
end

# Load autojump
source /usr/share/autojump/autojump.fish
