exa_cmd="exa --icons --group-directories-first --sort='.name' --git -Gh"
alias ls="${exa_cmd} -a"
alias ll="${exa_cmd} -l"
alias la="${exa_cmd} -al"
alias tree="${exa_cmd} -Ta --git-ignore --ignore-glob='.git'"
alias cwd="pwd"

alias please="sudo"
alias sus="sudo -Es"

alias icat="kitty +kitten icat"
alias ranger="pypy /usr/bin/ranger"
alias finder="ranger"
alias nano="micro"

alias gcal="gcalcli"
