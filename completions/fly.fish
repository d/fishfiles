function __fish_fly_targets
	sed -n 's/^  \([^[:space:]].*\):/\\1/p' ~/.flyrc
end

function __fish_fly_commands
	fly --help ^| sed -n '/Available commands:/,$p' | sed -E -n 's/  ([-[:alpha:]]+).*/\1/p'
end

function __fish_fly_targeted
	set --local cmd (commandline -opc)

	if [ (count $cmd) -eq 1 ]
		return 1
	else
		echo $cmd
		for c in $cmd[2..-1]
			if [ $c = "--target" ]
				return 0
			end
		end
	end
	return 1
end

complete --exclusive --command fly --long-option target --arguments '(__fish_fly_targets)' --description "Concourse target name"
complete --command fly --long-option help --description "Show this help message"
complete --command fly --long-option version --description "Print the version of Fly and exit"
complete --command fly --no-files --condition '__fish_fly_targeted' --arguments '(__fish_fly_commands)'
