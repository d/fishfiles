set -x EDITOR "gvim -f"

complete -f -c git -n '__fish_git_using_command pull' -l ff-only -d 'Refuse to merge unless fast-forward possible'
complete -f -c git -n '__fish_git_using_command pull' -l rebase -d 'Rebase instead of merge'
complete -c git -n '__fish_git_using_command commit' -s v -l verbose -d 'Show diff in commit message template'
complete -c git -n '__fish_git_using_command commit' -s a -l all -d 'Commit all changed files'

if test -d ~/.rbenv/shims;
	set PATH ~/.rbenv/shims $PATH
end
