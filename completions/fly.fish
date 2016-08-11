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
		for c in $cmd[2..-1]
			if [ $c = "--target" ]
				return 0
			end
		end
	end
	return 1
end

# command is the subcommand following `fly`
function __fish_fly_using_command --argument command
	# the command line to be auto-completed
	set --local cmd (commandline -opc)

	if [ (count $cmd) -gt 1 ]
		set --local skip_next 1
		for c in $cmd[2..-1]
			if [ $skip_next -eq 0 ]
				set skip_next 1
				continue
			end
			switch $c
				case '--target'
					set skip_next 0
					continue
				case '--*'
					continue
				case $command
					return 0
				case '*'
					return 1
			end
		end
	else
		return 1
	end
end

function __fish_fly_needs_command
	if [ (count (commandline -opc)) -lt 4 ]
		return 0
	else
		return 1
	end
end

complete --exclusive --command fly --long-option target --arguments '(__fish_fly_targets)' --description "Concourse target name"
complete --command fly --long-option help --description "Show this help message"
complete --command fly --long-option version --description "Print the version of Fly and exit"
complete --command fly --no-files --condition '__fish_fly_targeted; and __fish_fly_needs_command' --arguments '(__fish_fly_commands)'

complete --command fly --condition '__fish_fly_using_command hijack' --long-option job --description 'Name of a job to hijack'
complete --command fly --condition '__fish_fly_using_command hijack' --long-option check --description "Name of a resource's checking container to hijack"
complete --command fly --condition '__fish_fly_using_command hijack' --long-option build --description 'Build number within the job, or global build ID'
complete --command fly --condition '__fish_fly_using_command hijack' --long-option step --description 'Name of step to hijack (e.g. build, unit, resource name)'
complete --command fly --condition '__fish_fly_using_command hijack' --long-option attempt --description 'Attempt number of step to hijack. Can be specified multiple times for nested retries'
