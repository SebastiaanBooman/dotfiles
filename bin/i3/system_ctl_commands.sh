#!/bin/bash

prompt=""
reboot=false

if [[ $1 == "reboot" ]]; then
	prompt="REBOOT? [Y/n]"
	reboot=true
elif [[ $1 == "poweroff" ]]; then
	prompt="POWER OFF? [Y/n]"
else
	echo 'Error: must supply first argument as either "reboot" or "poweroff"'
	return 1
fi

echo $prompt
read input
if [[ "$input" == "y" || "$input" == "Y" || -z "$input" ]]; then
	if [ $reboot = true ]; then
		sudo reboot
		exit 0
	else
		sudo poweroff
		exit 0
	fi
fi

# Go back to previous workspace
/$HOME/bin/i3/workspace-history -mode=back
