#!/bin/bash
# Note: taken from https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist

export XDG_CURRENT_DESKTOP=sway

# Import the WAYLAND_DISPLAY env var from sway into the systemd user session
dbus-update-activation-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP=sway SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME
dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP=sway SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME

systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME

systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
systemctl --user start pipewire wireplumber
