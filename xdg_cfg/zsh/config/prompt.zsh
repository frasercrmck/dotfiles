autoload -U colors && colors

# Remove delay in mode switching
KEYTIMEOUT=5

_set_block_cursor() {
  echo -ne '\e[2 q'
}
_set_beam_cursor() {
  echo -ne '\e[5 q'
}

function zle-keymap-select {
  if [ ${KEYMAP} = "vicmd" ]; then
    _set_block_cursor
  elif [[ ${KEYMAP} =~ "main|viins" ]]; then
    _set_beam_cursor
  fi
}

zle -N zle-keymap-select

precmd_functions+=(_set_beam_cursor)

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode
# indicator, while in fact you would be in INS mode Fixed by catching SIGINT
# (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything
# else depends on it, we will not break it Thanks Ron! (see comments)
function TRAPINT() {
  _set_beam_cursor
  return $(( 128 + $1 ))
}

vim_time_prompt() {
  CUR_DIR="%(5~|%-1~/…/%3~|%4~)"
  HNAME=""
  if [[ -n "$SSH_CLIENT" ]]; then
    HNAME="·%B%F{red}%m%f%b"
  fi
  PROMPT='%B[%F{yellow}%n%f%F{green}@%f%F{blue}%m%f]%b${HNAME}%# '
  RPROMPT="(%B${CUR_DIR}%b)"
  RPROMPT2=${RPROMPT}
}

vim_time_prompt
