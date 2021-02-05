function h -d "faster shell navigation of projects"
	set -l _h_dir (command h --resolve "/home/reese/git" "$argv")
	set -l _h_ret $status
	test "$_h_dir" != "$PWD" && cd "$_h_dir"
	return $_h_ret
end
