#!/bin/bash

mkfifo /tmp/xobpipe
# Have xob consume new values as they arrive on the pipe
tail -f /tmp/xobpipe | xob
