#!/bin/bash
fzf --preview="$HOME/bin/fzf/preview_fzf.sh {}" --bind "enter:execute($HOME/bin/fzf/enter_bindings.sh {})"

