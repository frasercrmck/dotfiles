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

# put ccache first on the path
# pip installs binaries in ~/.local/bin
export PATH=/usr/lib/ccache:~/.local/bin:$PATH
# /usr/local/lib is a common place for user-built libraries
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
