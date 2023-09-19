autoload -U colors && colors

# Remove delay in mode switching
KEYTIMEOUT=5

_set_block_cursor() {
  echo -ne '\e[2 q'
}
_set_beam_cursor() {
  echo -ne '\e[5 q'
}

# Taken from https://github.com/vincentbernat/zshrc/blob/master/rc/bookmarks.zsh
# Bookmarks are symlinks stored in $XDG_DATA_HOME/markpaths, e.g.,
#   woof -> /home/fraser/woof
# Creates a dynamic directory name ~[@woof] which points to /home/fraser/woof
zsh_directory_name() {
  emulate -L zsh
  setopt extendedglob
  MARKPATH=$XDG_DATA_HOME/markpaths
  case $1 in
    n)
      [[ $2 != (#b)"@"(?*) ]] && return 1
      typeset -ga reply
      reply=(${${:-$MARKPATH/$match[1]}:A})
      return 0
      ;;
    d)
      local link slink split_slink
      local -A links
      for link ($MARKPATH/*(N@)) {
        links[${#link:A}$'\0'${link:A}]=${link:t}
      }
      for slink (${(@On)${(k)links}}) {
        #link=${slink#*$'\0'}
        split_slink=("${(@s/'\0'/)slink}")
        link=$split_slink[2]
        if [[ $2 = (#b)(${link})(|/*) ]]; then
          typeset -ga reply
          reply=("@"${links[$slink]} $(( ${#match[1]} )) )
          return 0
        fi
      }
      return 1
      ;;
    c)
      # Completion
      local expl
      local -a dirs
      dirs=($MARKPATH/*(N@:t))
      dirs=("@"${^dirs})
      _wanted dynamic-dirs expl 'bookmarked directory' compadd -S\] -a dirs
      return
      ;;
    *)
      return 1
      ;;
  esac
  return 0
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
