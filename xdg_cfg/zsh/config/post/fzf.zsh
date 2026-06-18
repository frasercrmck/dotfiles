# FZF bindings

# Load keybindings
if (( $+commands[fzf] )) && fzf --zsh &>/dev/null; then
  source <(fzf --zsh)
elif [ -f "$XDG_CONFIG_HOME/fzf/fzf.zsh" ]; then
  source "$XDG_CONFIG_HOME/fzf/fzf.zsh"
elif [ -d "/usr/share/doc/fzf/examples" ]; then
  for config in /usr/share/doc/fzf/examples/*.zsh; do
    source $config
  done
else
  echo 'Unable to source fzf zsh config'
fi

# Preview Alt+C directory with 'tree'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export FZF_CTRL_T_OPTS="--height 60% \
  --border sharp \
  --layout reverse \
  --prompt '∷ ' \
  --pointer ▶ \
  --marker ⇒ \
  --preview 'bat -n --color=always {}'"

# Reverse the Ctrl-R view, add preview toggle with '?'
export FZF_CTRL_R_OPTS="--reverse \
  --exact
  --no-sort
  --preview 'echo {}'
  --preview-window down:3:hidden:wrap
  --bind '?:toggle-preview'"
