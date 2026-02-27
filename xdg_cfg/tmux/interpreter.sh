#!/usr/bin/env bash

set -e

interpreters=()

add() {
  local interp=$1
  if command -v $interp &> /dev/null; then
    interpreters+=($(which $interp))
  fi
}

add gdb
add ipython
add python
add lua
add luajit
add node

add bash
add zsh
add fish

interpreter=$(
  echo "${interpreters[@]}" | tr ' ' '\n' |
  fzf --layout=reverse --info=hidden --border=none --cycle
)

$interpreter

exit
