# We also need this file in case ZDOTDIR is already set when launching zsh, in
# which case this file is sourced and its skip_global_compinit is taken by
# /etc/zsh/zshrc

export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# I'll do my own compinit, thank you
skip_global_compinit=1

# Work around firefox snap bug
export MOZ_ENABLE_WAYLAND=1

export WLR_NO_HARDWARE_CURSORS=1
