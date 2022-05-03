function stfu --argument-names cmd -d "Silence stderr of a command"
	command $cmd "$argv[2..-1]" 2> /dev/null # < /dev/null
end
