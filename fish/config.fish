# stuff for all shells
if test -e ~/.profile
	fenv source ~/.profile
end
if test -e ~/.bash_aliases
	bass source ~/.bash_aliases
end

# bobthefish theme settings
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal2-light
set -g theme_nerd_fonts yes

# fix for SSH colors - https://github.com/fish-shell/fish-shell/issues/7701
# always enable 24-bit color
set -g fish_term24bit 1

# Load zoxide
zoxide init fish | source
