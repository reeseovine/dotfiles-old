set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_color_scheme terminal-light-black

# Add dirs to $PATH
export PATH="$PATH:/home/reese/Programs/processing-3.5.4/":/home/reese/go/bin/

# Register SSH key(s)
ssh-add ~/.ssh/git_ed35519 &>/dev/null

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor and other programs
export XDG_CURRENT_DESKTOP=i3-gaps
export RANGER_LOAD_DEFAULT_RC=FALSE
export TERMINAL=kitty
export EDITOR=nano
export PAGER=less
export NODE_PATH=/usr/lib/node_modules/

# git-get environment variables
export GIT_PATH=/home/reese/git/
export GIT_GET_DEFAULT_PREFIX=git@github.com:

# import bash aliases
if test -e ~/.bash_aliases
    source ~/.bash_aliases
end

# Load autojump
source /usr/share/autojump/autojump.fish

# `git get && cd` shorthand
function gg --description "clone using git-get and change directory" --argument url
	set -l dir (git get $url)
	if test -n "$dir"; cd $dir
	end
end
