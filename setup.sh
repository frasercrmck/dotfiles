#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ${script_dir}

cd ~/

for file in .vimrc .zshrc .zshenv .bashrc .xinitrc .Xresources .ycm_extra_conf.py
do
  if [ ! -f ${script_dir}/${file} ]; then
    echo "File '${script_dir}/${file}' does not exist!"
    continue
  fi
  if [ -f ${file} ]; then
    rm ${file} 2> /dev/null
  fi
  set -x
  ln -s ${script_dir}/${file} ${file}
  { set +x; } 2>/dev/null
done

for dir in .i3 .config/nvim .vim .zsh-config
do
  if [ ! -d ${script_dir}/${dir} ]; then
    echo "Directory '${script_dir}/${dir}' does not exist!"
    continue
  fi
  if [ -d ${dir} ]; then
    rm -r ${dir} 2> /dev/null
  fi
  set -x
  ln -s ${script_dir}/${dir} ${dir}
  { set +x; } 2>/dev/null
done
