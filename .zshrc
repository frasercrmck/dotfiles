# Created by newuser for 5.0.2 autoload -U compinit promptinit compinit
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit

# Prevent Ctrl-S from freezing
stty -ixon

# Prevent Ctrl-D from exiting
setopt ignoreeof

setopt promptsubst
setopt transient_rprompt

# Source fancy prompt
source $HOME/.zsh-config/.zsh-prompt.zsh
vim_time_prompt

# Source other things
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Aliases
alias ls='ls --color=auto'
alias grepc='grep --color -HinRI'

# Prevent from putting duplicate lines in the history
setopt HIST_IGNORE_DUPS

# Save history across sessions
setopt inc_append_history
setopt share_history

HISTSIZE=4000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=4000

# Vim bindings
source $HOME/.zsh-config/.zsh-vim.zsh

# Change XTERM title
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

export PULSE_LATENCY_MSEC=60

PERL_MB_OPT="--install_base \"/home/fraser/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/fraser/perl5"; export PERL_MM_OPT;
