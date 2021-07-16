exa_cmd="exa --icons --group-directories-first --sort='.name' --git -Gh"
alias ls="${exa_cmd} -a"
alias ll="${exa_cmd} -lg"
alias la="${exa_cmd} -alg"
alias tree="${exa_cmd} -Ta --git-ignore --ignore-glob='.git'"
alias cwd="pwd"

alias please="sudo"
alias sus="sudo -Es"

alias icat="kitty +kitten icat"
alias ranger="pypy /usr/bin/ranger"
alias finder="ranger"
alias nano="micro"
alias subl="sublime_text"

alias haste="haste-client -d https://haste.seaofvoic.es"

alias pipes="pipes.sh -f 60 -s 15 -r 4000 -R"
alias bonsai="cbonsai -S"
