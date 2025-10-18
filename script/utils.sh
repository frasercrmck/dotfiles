#!/bin/bash

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  exit
}

prompt () {
  printf "\r  [ \033[0;33m??\033[0m ] $1 [y]es [n]o"
  read -s -n 1 action

  case "${action}" in
    y )
      printf "\r  [ \033[0;32m✓✓\033[0m ] $1 [\033[00;32mY\033[0m]es [n]o\n"
      return 1
      ;;
    * )
      printf "\r  [ \033[0;31m✕✕\033[0m ] $1 [y]es [\033[0;31mN\033[0m]o\n"
      return 0
      ;;
  esac
}
