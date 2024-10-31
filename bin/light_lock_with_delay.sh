#!/bin/bash

# Fixes issue where keyboard inputs are not registering after 
# idle locking with xss-lock in i3 config
sleep 0.5
light-locker-command -l
