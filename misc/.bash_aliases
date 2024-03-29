exa_cmd="exa --icons --group-directories-first --sort='.name' --git -Gh"
alias ls="${exa_cmd} -a"
alias ll="${exa_cmd} -lg"
alias la="${exa_cmd} -alg"
alias tree="${exa_cmd} -Ta --git-ignore --ignore-glob='.git'"

alias bat="bat --theme=ansi"
alias cwd="pwd"

alias please="sudo"
alias sus="sudo -Es"

alias dd="sudo dd bs=4M status=progress"
alias chex="chmod +x"

alias ga="git add . && git status"
alias gc="git commit -v"
alias gl="git log --oneline --no-decorate"
alias gp="git push"
alias gr="git remote -v"
alias gs="git status"

alias dc="docker compose"
alias dcb="docker compose build"
alias dcl="docker compose logs -f"
alias dcps="docker compose ps"
alias dcr="docker compose restart"
alias dcs="docker compose stop"
alias dcu="docker compose up -d --remove-orphans"

alias icat="kitty +kitten icat"
# alias ranger="pypy /usr/bin/ranger"
alias finder="ranger"
alias nano="micro"
alias hx="helix"
alias subl="subl -a"

alias pipes="pipes-rs"
alias bonsai="cbonsai -S"

alias rofi-mullvad='python3 /home/reese/git/git.cyberia.club/reese/rofi-mullvad/main.py'
alias backup="cat .config/backup/includelist | borg create --progress --paths-from-stdin '::{now:%Y%m%d_%H%M%S}'"
