# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi



# Add dirs to $PATH
export PATH="$PATH:/home/reese/Programs/processing-3.5.4/:/home/reese/go/bin/:/home/reese/scripts/"

# Register SSH keys
eval "$(ssh-agent -s)" &>/dev/null
ssh-add $HOME/.ssh/git_ed35519 &>/dev/null

# Preferred editor and other program preferences
export RANGER_LOAD_DEFAULT_RC=FALSE
export TERMINAL=kitty
export EDITOR=micro
export MICRO_TRUECOLOR=1
export PAGER=less
export LANG=en_US.UTF-8
export NODE_PATH=/usr/lib/node_modules/
export QT_QPA_PLATFORMTHEME=gtk2
export SUDO_ASKPASS=/home/reese/.local/bin/askpass-rofi

# git-get environment variables
export GIT_PATH=/home/reese/git/

# Cargo (rust package manager)
source "$HOME/.cargo/env"

# Set cursor shape to BEAM
printf "\033[6 q"
