autoload -U colors && colors

# normal
black="%{[0;30m%}"
red="%{[0;31m%}"
green="%{[0;32m%}"
yellow="%{[0;33m%}"
blue="%{[0;34m%}"
magenta="%{[0;35m%}"
cyan="%{[0;36m%}"
white="%{[0;37m%}"

# bold (grey is actually bold black)
grey="%{[01;30m%}"
bred="%{[01;31m%}"
bgreen="%{[01;32m%}"
byellow="%{[01;33m%}"
bblue="%{[01;34m%}"
bmagenta="%{[01;35m%}"
bcyan="%{[01;36m%}"
bwhite="%{[01;37m%}"

normal="%{[0m%}"

# example of background colour
# foreground white = 37
# background red = 41
fgwhitebgred="%{[0;37;41m%}"

vim_ins_mode="%B%F{cyan}[I]%f%b"
vim_cmd_mode="%B%F{green}[C]%f%b"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode
# indicator, while in fact you would be in INS mode Fixed by catching SIGINT
# (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything
# else depends on it, we will not break it Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

vim_time_prompt() {
  CUR_DIR="%(5~|%-1~/…/%3~|%4~)"
  PROMPT='[%B%D{%H:%M}%b] ${vim_mode} (%B%n%b)%#${normal} '
  RPROMPT="(%B${CUR_DIR}%b)${normal}"
  RPROMPT2=${RPROMPT}
}

vim_time_prompt

## run TRAPALRM every $TMOUT seconds
TMOUT=30

TRAPALRM () {
  ## reset-prompt - this will update the prompt
  zle reset-prompt
}
