# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
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
	color_prompt=yes
    fi
fi

#Synthaxe: \[\033[type;col\]
#Code couleur : 38 blanc, 31 rouge, 34 bleu, 30 noir, 32 vert
#Code fond 40 noir, 41 rouge, 42 vert, 47 blanc
#Code texte 1 gras, 4 sous-ligné
#cf. http://christopher.compagnon.name/sitewww/shell-color.html

export http_proxy=http://www-cache-in.curie.fr:3128
export ftp_proxy=http://www-cache-in.curie.fr:3128
export ssl_proxy=http://www-cache-in.curie.fr:3128
export socks_proxy=http://www-cache-in.curie.fr:3128
# Autocomplete for pdf for ev and okular
complete -f -X "!*.pdf" ev
complete -f -X "!*.pdf" ok

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\'
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;34m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h\[\033[1;37m\]:\[\033[1;31m\]\W\$\[\033[0;37m\]: \[\033[0;37m\]'
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
    alias ls='ls --color=auto -F'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -Alh'
alias la='ls -A'
alias l='ls -CF'

# Do grand total and use kibi division for size
alias du='du --si -s'

# prevent from deleting root and ask when deleting more than three files
alias rm='rm --preserve-root -I'

# launch the python3 instead of python2, and export numpy python3 library path
alias python3='export PYTHONPATH=$PYTHONPATH:/bioinfo/local/build/numpy_python3/lib/python3.1/site-packages/ ; /usr/bin/python3'
alias python='python3'
#python is a symbolic link in /usr/bin
# Python path for module search
export PYTHONPATH=$PYTHONPATH:$HOME/bin/binPython:$HOME/local/python3.1/site-packages/:
# File with commands to execute on python startup
export PYTHONSTARTUP=~/bin/binPython/startup.py

#Create symbolic links by default instead of hard links
alias ln='ln -s'

#Always allow interpretation of escaped caracters
alias echo='echo -e'

#Redirect firefox and thunderbird output errors
alias firefox='firefox >> .firefox.log'
#; echo "\n" >> .firefox.log 2>&1'
alias thunderbird='thunderbird >> .thunderbird.log'
#echo "\n" >> .thunderbird.log 2>&1'

#Enable X-forwarding with ssh connections
alias ssh='ssh -X'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#Allow to launch cytoscape from anyware without putting it in the bin folder
alias cytoscape2='$HOME/CytoscapeConfiguration/Cytoscape_v2.8.3/cytoscape.sh'
alias cytoscape3='export JAVA_HOME=/bioinfo/local/build/Java/jdk1.7.0_45/;export PATH=/bioinfo/local/build/Java/jdk1.7.0_45/bin:$PATH;~/src/Cytoscape_v3.2.0/cytoscape.sh'
alias cytoscape=cytoscape2

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Paths for the executables
export PATH=$PATH:~/Mail:/opt/lampp/bin/:~/bin
# :/home/$USER/bin
# Coloration by ls
export LS_COLORS=$LS_COLORS:'*.pdf=01;31:*.tex=01;38:'

#export VIMRUNTIME=~/.vim
export EDITOR=vim

# Always start emacs in the shell
alias emacs="emacs --no-window-system"

# Use plink without web check
alias plink="plink --noweb"

# Allow to use the boost C++ libraries
export BOOST_ROOT=/usr/local/include/boost_1_54_0

# Execute gcc and g++ with debug options
alias g++='g++ -Wall -Wextra -Wpointer-arith -Wcast-qual -Wcast-align'
alias gcc='gcc -Wall -Wextra -Wpointer-arith -Wcast-qual -Wcast-align'
alias g++strict='g++ -Werror'
# Create smaller -s and faster -O2 executables, have to be fully debugged
alias g++optimize='g++ -Os -s -O2'
# Directories for the external libraries (especially in C++)
export LIBRARY_PATH=$LIBRARY_PATH:/usr/include:/bioinfo/local/build/R-3.1.0 # Used during compilation
export LD_LIBRARY_PATH=$LIBRARY_PATH:/usr/include:/bioinfo/local/build/R-3.1.0 # Used during execution for shared libraries


#Activation des applets
#indicator-keylock

# Alias for converting pandoc markdown to other filetypes
alias pan2html='pandoc -s -f markdown -t html'
alias pan2latex='pandoc -s -f markdown -t latex'
alias pan2beamer='pandoc -s -f markdown -t beamer'
alias pan2slidy='pandoc -s -f markdown -t slidy'

# Alias to open markup folders
alias video='nautilus ~/Vidéos'
alias image='nautilus ~/Images'

# Alias for recursivity in rsync
alias rsync='rsync -r'

# Edit history match with !
shopt -s histverify

# Lines added by the Vim-R-plugin command :RpluginConfig (2014-déc.-04 13:02):
# Change the TERM environment variable (to get 256 colors) and make Vim
# connecting to X Server even if running in a terminal emulator (to get
# dynamic update of syntax highlight and Object Browser):
if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-256color" ]
then
    export TERM=xterm-256color
    export HAS_256_COLORS=yes
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
    export TERM=screen-256color
fi
if [ "x$DISPLAY" != "x" ]
then
    alias vim="vim --servername VIM"
    if [ "$HAS_256_COLORS" = "yes" ]
    then
        function tvim(){ tmux new-session "TERM=screen-256color vim --servername VIM $@" ; }
    else
        function tvim(){ tmux new-session "vim --servername VIM $@" ; }
    fi
else
    if [ "$HAS_256_COLORS" = "yes" ]
    then
        function tvim(){ tmux new-session "TERM=screen-256color vim $@" ; }
    else
        function tvim(){ tmux new-session "vim $@" ; }
    fi
fi
