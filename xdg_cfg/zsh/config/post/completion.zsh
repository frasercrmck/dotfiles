zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit

# On slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  This little hack
# restricts it to once a day.
zcompdump_dir="$XDG_CACHE_HOME"/zsh
zcompdump_file=$zcompdump_dir/zcompdump-$ZSH_VERSION

# The result of this find command prints (to stdout):
#   a) the file name it exists and it's older than 1 day
#   b) an error message if it does not exist
# Both of these are treated as non-empty, in which case the cached file is regenerated.
[ "$(find $zcompdump_file -mtime +0 2>&1)" ] && { mkdir -p $zcompdump_dir && compinit -d $zcompdump_file }
compinit -C -d $zcompdump_file

# Also show dot files when completing
_comp_options+=(globdots)
