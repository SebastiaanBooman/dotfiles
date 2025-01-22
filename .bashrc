# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

eval "$(fzf --bash)"


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'

alias ytm='$HOME/src/FirefoxExtensions/youtube-music-discord-rich-presence/server/main'
alias gm="mplayer '/home/seb/Music/Guided Mediation 20.m4a'"
alias vim="nvim"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias fzf='fzf --preview="$HOME/bin/fzf/preview_fzf.sh {}" --bind "enter:execute($HOME/bin/fzf/enter_bindings.sh {})"'

# have ls run after commands
function cd { 
    builtin cd "$@" && ls 
}

function fzfls { 
    ls | fzf
}

# Path for storing the directory name to CD into after selecting a directory using fzf
export FZF_CD_DIRECTORY_PATH="$HOME/fzf_cd_directory"

function fzfd { 
    # only list directories
    find . -type d | fzf --preview="$HOME/bin/fzf/preview_fzf.sh {}" --bind "enter:execute($HOME/bin/fzf/enter_bindings.sh {})+abort"
    if [ -f "$FZF_CD_DIRECTORY_PATH" ]; then
	directory_to_cd_into=$(head -n 1 $FZF_CD_DIRECTORY_PATH)
	cd $directory_to_cd_into
	find . -maxdepth 1 | fzf
	rm $FZF_CD_DIRECTORY_PATH
    fi
}

function cls { 
    clear "$@" && ls 
}

# navigation
function cd... { 
    builtin cd '../../'
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR="nvim"

export JAVA_HOME="$HOME/bin/jdk-23.0.1/"

export PATH="$HOME/bin/gradle-8.12/bin:$PATH"

# Add programming languages to $PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
(eval "$(pyenv init --path)") &> /dev/null

export PATH="/usr/local/go/bin:$PATH"
export PATH="/$HOME/go/bin:$PATH"

export PATH="$HOME/bin/jdk-23.0.1/bin:$PATH"

# i3-sensible-terminal checks $TERMINAL variable with highest prio
if [ -f /usr/bin/alacritty ]; then
    export TERMINAL=/usr/bin/alacritty
fi

# git bare repository alias for dotfiles storage
alias cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/"

eval "$(ssh-agent)" 1> /dev/null
ssh-add $HOME/.ssh/github_main &> /dev/null

alias python=python3
alias c=clear

# git
alias ga="git add"
alias gd="git diff"
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias gcl="git-clone-bare"
alias gb="git branch"
alias gch="git checkout"
alias gw="git worktree"

alias gob="go build"

