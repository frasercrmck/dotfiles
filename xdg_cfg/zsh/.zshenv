# We also need this file in case ZDOTDIR is already set when launching zsh, in
# which case this file is sourced and its skip_global_compinit is taken by
# /etc/zsh/zshrc

export EDITOR=nvim
export GTK_USE_PORTAL=0

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
# sway doesn't seem to set this automatically, for some reason
[ "$GDMSESSION" = "sway" ] && export XDG_CURRENT_DESKTOP=sway

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export CMAKE_EXPORT_COMPILE_COMMANDS=ON

# I'll do my own compinit, thank you
skip_global_compinit=1

# Work around firefox snap bug
export MOZ_ENABLE_WAYLAND=1

export WLR_NO_HARDWARE_CURSORS=1
