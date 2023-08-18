autoload -U colors && colors

# Remove delay in mode switching
KEYTIMEOUT=5

function zle-keymap-select {
  if [ ${KEYMAP} = "vicmd" ]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} =~ "main|viins" ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select

_fix_cursor() {
  echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode
# indicator, while in fact you would be in INS mode Fixed by catching SIGINT
# (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything
# else depends on it, we will not break it Thanks Ron! (see comments)
function TRAPINT() {
  _fix_cursor
  return $(( 128 + $1 ))
}

vim_time_prompt() {
  CUR_DIR="%(5~|%-1~/…/%3~|%4~)"
  HNAME=""
  if [[ -n "$SSH_CLIENT" ]]; then
    HNAME="·%B%F{red}%m%f%b"
  fi
  PROMPT='[%B%F{cyan}%n%f%b@%B%F{green}%m%f%b]${HNAME}·%# '
  RPROMPT="(%B${CUR_DIR}%b)"
  RPROMPT2=${RPROMPT}
}

vim_time_prompt
