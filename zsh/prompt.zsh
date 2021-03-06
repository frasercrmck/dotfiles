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

function preexec_prompt_timer() {
  timer=${timer:-$SECONDS}
}
# Load the timer function into the set of preexecs
preexec_functions+=(preexec_prompt_timer)

last_time=${SECONDS}

function precmd_prompt_timer() {
  if [ $timer ]; then
    last_time=$(($SECONDS - $timer))
    unset timer
  fi
}
# Load the timer function into the set of precmds
precmd_functions+=(precmd_prompt_timer)

vim_time_prompt() {
  CUR_DIR="%(5~|%-1~/…/%3~|%4~)"
  HNAME=""
  if [[ -n "$SSH_CLIENT" ]]; then
    HNAME="·%B%F{red}%m%f%b"
  fi
  PROMPT='[%B%D{%H:%M}%b/%B%F{yellow}${last_time}s%f%b]${HNAME}·${vim_mode}%# '
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
