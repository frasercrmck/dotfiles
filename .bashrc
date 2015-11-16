#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source csh compatibility functions
source ~/.config/csh_compat.sh

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias grepc='grep --color -nRHi'

IGNOREEOF=1
