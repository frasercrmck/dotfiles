#!/bin/bash

COLOURS=(
  F8B195 # Tangerine
  F67280 # Light red
  C06C84 # Sunset
  6C5B7B # Purple
  C55C7D # Dark blue
  A8E6CE # Turqouiseish
  DCEDC2 # Lime-Greenish
  FFD3B5 # Orangeish
  FFAAA6 # Pinkish
  FF8C94 # Reddish
  EFDD6F # Yellow
# Colours stolen from catppuccin macchiatto:
# https://github.com/catppuccin/foot/blob/main/catppuccin-macchiato.conf
  24273A # Background
  CAD3F5 # Text
  494D64 # Surface 1
  B8C0E0 # Subtext 1
  5B6078 # Surface 2
  A6DA95 # Green
  EED49F # Yellow
  F5BDE6 # Pink
  8BD5CA # Teal
  A5ADCB # Subtext 0
)

RANDOM=$$$(date +%s)

COLOUR=${COLOURS[${RANDOM} % ${#COLOURS[@]}]}

swaylock -f -c ${COLOUR}
