# Created by newuser for 5.0.2 autoload -U compinit promptinit compinit
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit

# Prevent Ctrl-S from freezing
stty -ixon

setopt promptsubst
setopt transient_rprompt
# Prevent from putting duplicate lines in the history
setopt HIST_IGNORE_DUPS

source $HOME/.prompt
vim_time_prompt

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

alias ls='ls --color=auto'
alias grepc='grep --color -nRHi'

# Save history across sessions
setopt inc_append_history
setopt share_history

HISTSIZE=1000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=1000

# Vim bindings
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd '?'  history-incremental-search-backward
bindkey -M vicmd ':'  vi-repeat-find

bindkey -M viins '^o' vi-backward-kill-word

bindkey -M vicmd 'yy' vi-yank-whole-line
bindkey -M vicmd 'Y'  vi-yank-eol

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey -M vicmd '^r' history-incremental-pattern-search-backward
bindkey -M viins '^s' history-incremental-pattern-search-forward
bindkey -M vicmd '^s' history-incremental-pattern-search-forward

bindkey -M viins '^p' up-line-or-history
bindkey -M viins '^n' down-line-or-history

bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^H" backward-delete-char

bindkey -M viins '^u' vi-kill-line
bindkey -M vicmd '^u' vi-kill-line

bindkey -M viins '^k' kill-line
bindkey -M vicmd '^k' kill-line

bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^e' vi-end-of-line


# Change XTERM title
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

bindkey -v

