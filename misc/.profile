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
export PATH="$PATH:$HOME/Programs/bin:$HOME/Programs/platform-tools:$HOME/go/bin:$HOME/git/gitlab.com/katacarbix/dotfiles/scripts:/opt/piavpn/bin"

# Register SSH keys
eval "$(ssh-agent -s)" &>/dev/null
ssh-add $HOME/.ssh/git_ed25519 &>/dev/null

# Preferred editor and other program preferences
export RANGER_LOAD_DEFAULT_RC=FALSE
export TERMINAL=kitty
export EDITOR=micro
export MICRO_TRUECOLOR=1
export PAGER=less
export NODE_PATH=/usr/lib/node_modules/
export QT_QPA_PLATFORMTHEME=gtk2
export SUDO_ASKPASS=$HOME/scripts/rofi/askpass

# Android development
export ANDROID_HOME=$HOME/Programs/android-sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

# Cargo (rust package manager)
source "$HOME/.cargo/env"

# Set cursor shape to BEAM
printf "\033[6 q"
