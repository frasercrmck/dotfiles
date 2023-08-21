# Disable automatic widget re-binding on each precmd - much faster!
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source "$ZDOTDIR/functions.zsh"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

zsh_load_configs

precmd_set_xterm_title() {
  print -Pn "\e]0;%n@%m: %~\a"
}

# Change XTERM title
case ${TERM} in
  xterm*)
    precmd_functions+=(precmd_set_xterm_title)
    ;;
esac

# pip installs binaries in ~/.local/bin
zsh_prepend_to_path ~/.local/bin
# put ccache first on the path
zsh_prepend_to_path /usr/lib/ccache

# /usr/local/lib is a common place for user-built libraries
zsh_prepend_to_ld_library_path /usr/local/lib
