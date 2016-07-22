function __fish_fly_targets
	sed -n 's/^  \([^[:space:]].*\):/\\1/p' ~/.flyrc
end

function __fish_fly_commands
	fly --help ^| sed -n '/Available commands:/,$p' | sed -E -n 's/  ([-[:alpha:]]+).*/\1/p'
end

complete --exclusive --command fly --long-option target --arguments '(__fish_fly_targets)' --description "Concourse target name"
complete --command fly --long-option help --description "Show this help message"
complete --command fly --long-option version --description "Print the version of Fly and exit"
complete --command fly --no-files --arguments "(__fish_fly_commands)"
