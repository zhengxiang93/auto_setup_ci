#!/bin/bash

# Check dependencies for Avocado and Avocado-VT

PROGNAME=check_dependencies.sh

function error_exit
{
	#	----------------------------------------------------------------
	#	Function for exit due to fatal program error
	#		Accepts 1 argument:
	#			string containing descriptive error message
	#	----------------------------------------------------------------

	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
		exit 2
}

declare -a tools=("gcc" "git" "python" "pip" "xz" "tcpdump" "nc" "ip" \
                  "arping" "fakeroot" "brctl" "lkvm")
for tool in "${tools[@]}"
do
	if ! tool_loc="$(type -p "$tool")" || [ -z "$tool_loc" ]; then
		  error_exit "$tool is required, please install"
	fi
done

echo "All denpendencies is ok!"
