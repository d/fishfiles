if type --force-path gvim &> /dev/null;
	set -x EDITOR gvim -f
end

complete -f -c git -n '__fish_git_using_command pull' -l ff-only -d 'Refuse to merge unless fast-forward possible'
complete -f -c git -n '__fish_git_using_command pull' -l rebase -d 'Rebase instead of merge'
complete -c git -n '__fish_git_using_command commit' -s v -l verbose -d 'Show diff in commit message template'
complete -c git -n '__fish_git_using_command commit' -s a -l all -d 'Commit all changed files'

if type --force-path direnv &> /dev/null;
	eval (direnv hook fish)
end

if not type --force-path brew &> /dev/null; and test -e /opt/homebrew/bin/brew;
	eval (/opt/homebrew/bin/brew shellenv fish)
end

if test -d ~/.rbenv/shims;
	set PATH ~/.rbenv/shims $PATH
end
