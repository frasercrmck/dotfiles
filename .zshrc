autoload -U colors && colors
autoload -U promptinit && promptinit

stty -ixon                # Prevent Ctrl-S from freezing

setopt ignoreeof          # Prevent Ctrl-D from exiting

setopt promptsubst        # ALlow parameter, command, etc, in prompt
setopt transient_rprompt  # Hide RPROMPT after cmdline is executed

# Source fancy prompt
source $HOME/.zsh-config/.zsh-prompt.zsh
vim_time_prompt

# Source other things
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Aliases
# -------
alias ls='ls --color=auto'
alias grepc='grep --color -HinRI'
alias agc='ag -S --nogroup'
alias vimr='vim --servername VIM_SERVER --remote'

# History & History Expansion
# ---------------------------
setopt extendedhistory      # Save timestamps in history
setopt histignoredups       # Ignore consecutive dups
setopt histfindnodups       # Backwards search produces diff result each time
setopt histreduceblanks     # Compact consecutive white space chars
setopt incappendhistory     # Incrementally add items to HISTFILE
# setopt share_history        # Share history between sessions

HISTSIZE=4000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=4000

# Vim Mode & Vim Bindings
# -----------------------
source $HOME/.zsh-config/.zsh-vim.zsh

# Change XTERM title
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

# Completion
# ==========

# The following lines were added by compinstall

zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/fraser/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Pulse Audio
# -----------
export PULSE_LATENCY_MSEC=60

PERL_MB_OPT="--install_base \"/home/fraser/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/fraser/perl5"; export PERL_MM_OPT;
