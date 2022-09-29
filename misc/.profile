# if running bash and .bashrc exists, include it
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

# Start SSH agent
if [ -z "${SSH_AGENT_PID}" ]
then
    if ! [ -e /tmp/ssh-agent-$USER ]; then
        ssh-agent -t 21600 2>/dev/null >/tmp/ssh-agent-$USER
    fi
    source /tmp/ssh-agent-$USER >/dev/null
fi


# Add to PATH
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/git/gitlab.com/katacarbix/dotfiles/scripts:$HOME/.rbenv/bin"

# Preferred editor and other program preferences
export EDITOR=micro
export PAGER=less
export TERMINAL=kitty
export MICRO_TRUECOLOR=1
export NODE_PATH=/usr/lib/node_modules/
export QT_QPA_PLATFORMTHEME=gtk2
export QT_SCALE_FACTOR=1.33
export RANGER_LOAD_DEFAULT_RC=FALSE
export SSH_ASKPASS=$HOME/scripts/rofi/askpass
export SUDO_ASKPASS=$HOME/scripts/rofi/askpass

# borg backup
export RESTIC_REPOSITORY="sftp://reese@layerze.ro:2222/backups/sad-machine"
export RESTIC_PASSWORD_COMMAND="pa s restic_pass"

# Android development
export ANDROID_HOME=$HOME/Programs/android-sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
export CCACHE_EXEC=/usr/bin/ccache
export USE_CCACHE=1

# Set cursor shape to BEAM
printf "\033[6 q"
