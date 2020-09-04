set -g theme_display_date no
set -g theme_color_scheme terminal

# Add dirs to $PATH
export PATH="/home/reese/bin:/home/reese/Programs/processing-3.5.4/:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor and other programs
export XDG_CURRENT_DESKTOP=i3-gaps
export RANGER_LOAD_DEFAULT_RC=FALSE
export TERMINAL=kitty
export EDITOR=nano
export PAGER=less

# git-get environment variables
export GIT_PATH=/home/reese/git/
export GIT_GET_DEFAULT_PREFIX=git@github.com:

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias python='python3'
alias pip='sudo -H pip3'
alias icat="kitty +kitten icat"

# Load autojump
source /usr/share/autojump/autojump.fish

# `git get && cd` shorthand
function gg --description "clone using git-get and change directory" --argument url
	set -l dir (git get $url)
	if test -n "$dir"; cd $dir
	end
end
