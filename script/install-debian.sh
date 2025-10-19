#!/bin/bash

source "$(dirname "$0")"/utils.sh

install_pack () {
  apt install -y "$@"
}

prompt_and_install () {
  packages="$@"
  prompt "Install $packages?"
  [ "$?" -eq "1" ] && install_pack "$@"
}

install_sway () {
  prompt "Install sway?"
  [ "$?" -eq "0" ] && info 'Skipping sway' && return

  info "Installing sway"

  install_pack sway swaylock swayidle swaybg

  # Things that my sway config uses
  install_pack wmenu waybar j4-dmenu-desktop \
    grim slurp libnotify-bin mako-notifier \
    brightnessctl playerctl pulseaudio-utils xclip wl-clipboard

  # Necessary for screen casting on wayland
  install_pack xdg-desktop-portal xdg-desktop-portal-wlr 
}

install_dev_tools () {
  prompt_and_install zsh

  prompt_and_install tmux

  prompt_and_install fzf grep ripgrep

  prompt_and_install ninja-build

  # Vim/Neovim use these for clipboard integrations
  prompt_and_install xclip wl-clipboard

  info "Installed dev tools"
}

info "Installing Basics"
apt install wget curl git

# Sway
install_sway

# Dev tools
install_dev_tools
