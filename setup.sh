#!/bin/bash -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ${SCRIPT_DIR}

HOME_DIR=~/

function symlink_file()
{
  local FILE=$1
  local LINK=$2

  if [ ! -f ${FILE} ]; then
    echo "File '${FILE}' does not exist!"
    return 0
  fi
  if [ -f ${LINK} ]; then
    rm ${LINK} 2> /dev/null
  fi
  set -x
  ln -s ${FILE} ${LINK}
  { set +x; } 2>/dev/null
}

for FILE in .zshrc .zshenv .bashrc .xinitrc .Xresources .ycm_extra_conf.py .config/csh_compat.sh
do
  symlink_file ${SCRIPT_DIR}/${FILE} ${HOME_DIR}/${FILE}
done

symlink_file ${SCRIPT_DIR}/.config/nvim/init.vim ${HOME_DIR}/.vimrc

function symlink_dir()
{
  local DIR=$1
  local LINK=$2

  if [ ! -d ${DIR} ]; then
    echo "Directory '${DIR}' does not exist!"
    return 0
  fi
  if [ -d ${LINK} ]; then
    rm -r ${LINK} 2> /dev/null
  fi
  set -x
  ln -s ${DIR} ${LINK}
  { set +x; } 2>/dev/null
}

for DIR in .i3 .config/nvim .vim .zsh-config
do
  symlink_dir ${SCRIPT_DIR}/${DIR} ${HOME_DIR}/${DIR}
done
