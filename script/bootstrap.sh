#!/bin/bash

# Taken from https://github.com/holman/dotfiles/script/bootstrap. Thanks!

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

export XDG_CONFIG_HOME="$HOME"/.config

source "$(dirname "$0")"/utils.sh

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

  local overwrite_all=false backup_all=true skip_all=false

  # Note this uses a POSIX extension (mindepth) to exclude the xdg_cfg directory itself.
  for src in $(find -H "${DOTFILES_ROOT}/home" -mindepth 1 -maxdepth 1)
  do
    dst="${HOME}/$(basename $src)"
    link_file "${src}" "${dst}"
  done

  # Ensure ${XDG_CONFIG_HOME} is present before symlinking in directories
  mkdir -p ${XDG_CONFIG_HOME}

  # Note this uses a POSIX extension (mindepth) to exclude the xdg_cfg directory itself.
  for src in $(find -H "${DOTFILES_ROOT}/xdg_cfg" -mindepth 1 -maxdepth 1 -type d)
  do
    dst="${XDG_CONFIG_HOME}/$(basename "${src%.*}")"
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
  prompt "Install fonts?"
  [ "$?" -eq "0" ] && info 'skipping fonts' && return

  info 'installing fonts'

  mkdir -p ~/.fonts

  for font in adobe-fonts/source-code-pro+OTF+otf adobe-fonts/source-sans+OTF+otf \
              adobe-fonts/source-serif+Desktop+otf ryanoasis/nerd-fonts+FiraCode+ttf
  do
    TEMP_DIR=$(mktemp -d /tmp/script.XXXXXXX)
    IFS=+ read -r -d '' family package suffix < <(printf %s "$font")
    font_file="$(
    curl -s https://api.github.com/repos/${family}/releases/latest \
    | grep "browser_download_url.*${package}.*\.zip" \
    | sed -re 's/.*: "([^"]+)".*/\1/' \
    )"
    if [[ -z "$font_file" ]]
    then
      info "could not find package for $family"
      continue
    fi
    info "downloading $font_file"
    wget --quiet $font_file -P $TEMP_DIR
    unzip -q $(find ${TEMP_DIR} -type f -name "*.zip") -d $TEMP_DIR
    cp $(find ${TEMP_DIR} -type f -name "*.${suffix}") ~/.fonts
    rm -rf $TEMP_DIR
  done

  ## Install them
  fc-cache -f -v
}

install_dotfiles

if [[ ! -d  $XDG_CONFIG_HOME/tmux/plugins/tpm ]]
then
  info 'installing tmux tpm'
  git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
else
  success 'skipped installing tmux tpm'
fi

install_fonts
