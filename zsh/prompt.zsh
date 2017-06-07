autoload -U colors && colors

vim_ins_mode="%B%F{cyan}[I]%f%b"
vim_cmd_mode="%B%F{green}[C]%f%b"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  if [ ${KEYMAP} = "vicmd" ]; then
    vim_mode=${vim_cmd_mode}
  elif [[ ${KEYMAP} =~ "main|viins" ]]; then
    vim_mode=${vim_ins_mode}
  fi
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
  PROMPT='[%B%D{%H:%M}%b] ${vim_mode} (%B%n%b)%# '
  RPROMPT="(%B${CUR_DIR}%b)"
  RPROMPT2=${RPROMPT}
}

vim_time_prompt

## run TRAPALRM every $TMOUT seconds
TMOUT=30

TRAPALRM () {
  ## reset-prompt - this will update the prompt
  zle reset-prompt
}
