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

# underscore (note additive ugrey)
ublack="%{[04;30m%}"
ugrey="%{[01;04;30m%}"
ured="%{[04;31m%}"
ugreen="%{[04;32m%}"
uyellow="%{[04;33m%}"
ublue="%{[04;34m%}"
umagenta="%{[04;35m%}"
ucyan="%{[04;36m%}"
uwhite="%{[04;37m%}"

# blinking
kgrey="%{[01;05;30m%}"
kred="%{[05;31m%}"
kgreen="%{[05;32m%}"
kyellow="%{[05;33m%}"
kblue="%{[05;34m%}"
kmagenta="%{[05;35m%}"
kcyan="%{[05;36m%}"
kwhite="%{[05;37m%}"

normal="%{[0m%}"

# example of background colour
# foreground white = 37
# background red = 41
fgwhitebgred="%{[0;37;41m%}"

# simple prompt
simple_prompt() {
	PROMPT="$bblue%n@%m(%~)%# $normal"
}

# raela's prompt
raela_prompt() {
	PROMPT="${green}[$normal%n$red@$normal%m $blue($normal%D{%a %b %d %H:%M:%S}$blue) $normal%/$green]$normal%# "
	RPROMPT=""
}

# extended prompt
ext_prompt() {
	PROMPT="${green}[$bgreen%n$green@$bgreen%m $blue(%D{%a %b %d %H:%M:%S}) $cyan%~$green]$green%#$normal "
	RPROMPT=""
}

white_prompt() {
	colour1=$white
	colour2=$bwhite
	PROMPT="$colour1($colour2%n$colour1@$colour2%m$colour1)%#$normal "
	RPROMPT="$colour1($colour2%~$colour1)$normal"
}

white_time_left_prompt() {
	colour1=$white
	colour2=$bwhite
	colour3=$grey
	PROMPT="${colour1}[$colour2%D{%H:%M:%S}$colour1] $colour1($colour2%n$colour1@$colour2%m$colour1)%#$normal "
	RPROMPT="$colour1($colour2%~$colour1)$normal"
}

red_time_left_prompt() {
	colour1=$red
	colour2=$bred
	colour3=$grey
	colour4=$white
	PROMPT="${colour4}[$colour3%D{%H:%M:%S}$colour4] $colour1($colour2%n$colour1@$colour2%m$colour1)%#$normal "
	RPROMPT="$colour1($colour2%~$colour1)$normal"
}

vim_ins_mode="%{$cyan%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$green%}[CMD]%{$reset_color%}"
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

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

vim_time_prompt() {
	colour1=$white
	colour2=$bwhite
	colour3=$grey
	PROMPT='${colour1}[$colour2%D{%H:%M}$colour1] $vim_mode $colour1($colour2%n$colour1@$colour2%m$colour1)%#$normal '
	RPROMPT="$colour1($colour2%~$colour1)$normal"
	RPROMPT2="$colour1($colour2%~$colour1)$normal"
}
