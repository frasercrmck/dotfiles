# Vim bindings
bindkey -M viins 'jk' vi-cmd-mode

function accept_then_cmd {
  accept-search
  vi-cmd-mode
}
zle -N accept_then_cmd

bindkey -M isearch 'j'  self-insert
bindkey -M isearch 'jk' accept_then_cmd
bindkey -M isearch '\e' accept_then_cmd

bindkey -M vicmd '?'  history-incremental-search-backward

bindkey -M viins '^o' vi-backward-kill-word

bindkey -M vicmd 'yy' vi-yank-whole-line
bindkey -M vicmd 'Y'  vi-yank-eol

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey -M vicmd '^r' history-incremental-pattern-search-backward
bindkey -M viins '^e' history-incremental-pattern-search-forward
bindkey -M vicmd '^e' history-incremental-pattern-search-forward

bindkey -M viins '^p' up-line-or-history
bindkey -M viins '^n' down-line-or-history

bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^H" backward-delete-char

bindkey -M viins '^u' vi-kill-line
bindkey -M vicmd '^u' vi-kill-line

bindkey -M viins '^k' kill-line
bindkey -M vicmd '^k' kill-line

# Switch them all on
bindkey -v
