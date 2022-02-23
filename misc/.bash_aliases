exa_cmd="exa --icons --group-directories-first --sort='.name' --git -Gh"
alias ls="${exa_cmd} -a"
alias ll="${exa_cmd} -lg"
alias la="${exa_cmd} -alg"
alias tree="${exa_cmd} -Ta --git-ignore --ignore-glob='.git'"
alias cwd="pwd"

alias please="sudo"
alias sus="sudo -Es"

alias dd="sudo dd status=progress"

alias ga="git add . && git status"
alias gd="git status"
alias gc="git commit -m"
alias gr="git remote -v"
alias gp="git push"

alias icat="kitty +kitten icat"
alias ranger="pypy /usr/bin/ranger"
alias finder="ranger"
alias nano="micro"
alias subl="sublime_text"

alias haste="haste-client -d https://haste.seaofvoic.es"

alias pipes="pipes-rs"
alias bonsai="cbonsai -S"
