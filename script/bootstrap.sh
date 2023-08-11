#!/bin/bash

# Taken from https://github.com/holman/dotfiles/script/bootstrap. Thanks!

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

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

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "${dst}" -o -d "${dst}" -o -L "${dst}" ]
  then

    if [ "${overwrite_all}" == "false" ] \
      && [ "${backup_all}" == "false" ] \
      && [ "${skip_all}" == "false" ]
    then
      local current_src="$(readlink ${dst})"

      if [ "${current_src}" == "${src}" ]
      then
        skip=true;
      else
        user "File already exists: ${dst} ($(basename "${src}")), what do you want to do?\n\
          [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "${action}" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "${overwrite}" == "true" ]
    then
      rm -rf "${dst}"
      success "removed ${dst}"
    fi

    if [ "${backup}" == "true" ]
    then
      mv "${dst}" "${dst}.backup"
      success "moved ${dst} to ${dst}.backup"
    fi

    if [ "${skip}" == "true" ]
    then
      success "skipped ${src}"
    fi
  fi

  if [ "${skip}" != "true" ]  # "false" or empty
  then
    errs=$( ln -s "$1" "$2" 2>&1 )
    [ "$?" != "0" ] && fail "$errs"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "${DOTFILES_ROOT}" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="${HOME}/.$(basename "${src%.*}")"
    link_file "${src}" "${dst}"
  done

  # Ensure ${HOME}/.config is present before symlinking in XDG_CONFIG_HOME directories
  mkdir -p ${HOME}/.config

  for src in $(find -H "${DOTFILES_ROOT}" -maxdepth 2 -name '*.xdg_cfg' -not -path '*.git*')
  do
    dst="${HOME}/.config/$(basename "${src%.*}")"
    link_file "${src}" "${dst}"
  done

  mkdir -p ${HOME}/.urxvt/ext
  for src in $(find -H "${DOTFILES_ROOT}/urxvt_scripts" -type f)
  do
    dst="${HOME}/.urxvt/ext/$(basename "${src%.*}")"
    link_file "${src}" "${dst}"
  done
}

install_fonts () {
  user "Install fonts? [y]es, [n]o"
  read -n 1 action

  case "${action}" in
    y )
      ;;
    * )
      return
      ;;
  esac

  info 'installing fonts'

  mkdir -p ~/.fonts
  TEMP_DIR=$(mktemp -d /tmp/script.XXXXXXX)

  for font in source-code-pro+OTF source-sans+OTF source-serif+Desktop
  do
    IFS=+ read -r -d '' family package < <(printf %s "$font")
    font_file="$(
    curl -s https://api.github.com/repos/adobe-fonts/${family}/releases/latest \
    | grep browser_download_url | grep ${package} \
    | sed -re 's/.*: "([^"]+)".*/\1/' \
    )"
    if [[ -z "$font_file" ]]
    then
      info "could not find package for $family"
      continue
    fi
    info "downloading $font_file"
    wget --quiet $font_file -P $TEMP_DIR
  done

  # Unzip them all
  for file in $(find $TEMP_DIR -type f -name "*.zip")
  do
    unzip $file -d $TEMP_DIR
  done

  cp $(find ${TEMP_DIR} -type f -name "*.otf") ~/.fonts

  # Install them
  fc-cache -f -v
  rm -rf $TEMP_DIR
}

install_dotfiles

if [[ ! -d  ~/.tmux/plugins/tpm ]]
then
  info 'installing tmux tpm'
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  success 'skipped installing tmux tpm'
fi

install_fonts
