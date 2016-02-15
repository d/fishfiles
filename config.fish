switch (uname);
	case Darwin
		set -x GIT_EDITOR "mvim -f"
	case '*'
		set -x EDITOR "vim"
end

complete -f -c git -n '__fish_git_using_command pull' -l ff-only -d 'Refuse to merge unless fast-forward possible'
complete -f -c git -n '__fish_git_using_command pull' -l rebase -d 'Rebase instead of merge'
complete -c git -n '__fish_git_using_command commit' -s v -l verbose -d 'Show diff in commit message template'
complete -c git -n '__fish_git_using_command commit' -s a -l all -d 'Commit all changed files'
complete -f -c git -n '__fish_git_using_command log' -l decorate -a 'short full no'
complete -f -c git -n '__fish_git_using_command push' -l force-with-lease -d 'require old value of ref to be at this value'

set -x GOPATH ~/.local/go
set PATH $GOPATH/bin ~/.rbenv/shims $PATH
