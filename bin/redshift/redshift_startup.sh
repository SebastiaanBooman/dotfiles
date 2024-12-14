#!/bin/bash

# Meant to be executed during startup with e.g xdg/autostart
# starts redshift if time is later than 16 

export DISPLAY=:0
current_time=$(date +"%H")
if [ $current_time -ge 20 ] || [ $current_time -lt 7 ];
then
	/usr/bin/redshift
fi
