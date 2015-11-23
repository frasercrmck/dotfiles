autoload -U colors && colors
autoload -U promptinit && promptinit

setopt ignoreeof          # Prevent Ctrl-D from exiting

setopt promptsubst        # ALlow parameter, command, etc, in prompt
setopt transient_rprompt  # Hide RPROMPT after cmdline is executed

# Source fancy prompt
source $HOME/.zsh-config/.zsh-prompt.zsh
vim_time_prompt

## run TRAPALRM every $TMOUT seconds
TMOUT=30

TRAPALRM () {
  ## reset-prompt - this will update the prompt
  zle reset-prompt
}

case `uname` in
  Darwin)
    IS_OSX=1
    ;;
esac

# Source other things
if [ ! $IS_OSX ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# Source csh compatibility functions
source ~/.config/csh_compat.sh

# Aliases
# -------
if [ $IS_OSX ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias grepc='grep --color -HinRI'
alias agc='ag -S --nogroup'
if [ $IS_OSX ]; then
  alias vim='mvim -v'
else;
  alias vim='nvim'
  export EDITOR=nvim
  export VISUAL=nvim
  export BROWSER=chromium
fi
alias vimr='vim --servername VIM_SERVER --remote'

# History & History Expansion
# ---------------------------
setopt extendedhistory      # Save timestamps in history
setopt histignoredups       # Ignore consecutive dups
setopt histfindnodups       # Backwards search produces diff result each time
setopt histreduceblanks     # Compact consecutive white space chars
setopt incappendhistory     # Incrementally add items to HISTFILE
# setopt share_history        # Share history between sessions

HISTSIZE=500000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=500000

# Vim Mode & Vim Bindings
# -----------------------
source $HOME/.zsh-config/.zsh-vim.zsh

# Change XTERM title & set 256-colours
case $TERM in
    xterm*)
        export TERM=xterm-256color
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

# LastPass
# -------
export LPASS_DISABLE_PINENTRY=1
