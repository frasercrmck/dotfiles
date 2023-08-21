if [ ${IS_OSX} ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias grepc='grep --color -HinRI'
alias rg='rg -S --no-heading --hidden'

command_exists () {
  command -v "$1" > /dev/null 2>&1
}

if [ ${IS_OSX} ]; then
  alias vim='mvim -v'
else;
  if command_exists nvim; then
    alias vim='nvim'
    export EDITOR=nvim
    export VISUAL=nvim
  fi
  export BROWSER=chromium
fi
