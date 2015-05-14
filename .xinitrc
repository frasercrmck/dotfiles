[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap -option ctrl:nocaps

export TERM=xterm-256color

exec i3
