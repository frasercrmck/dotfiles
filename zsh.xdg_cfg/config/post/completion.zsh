zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit

# On slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  This little hack
# restricts it to once a day.
[ ! "$(find $ZDOTDIR/.zcompdump -mtime 1)" ] || compinit
compinit -C
