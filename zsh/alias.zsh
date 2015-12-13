if [ ${IS_OSX} ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias grepc='grep --color -HinRI'
alias agc='ag -S --nogroup'

if [ ${IS_OSX} ]; then
  alias vim='mvim -v'
else;
  alias vim='nvim'
  export EDITOR=nvim
  export VISUAL=nvim
  export BROWSER=chromium
fi
