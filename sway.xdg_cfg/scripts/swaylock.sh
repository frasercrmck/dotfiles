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
)

RANDOM=$$$(date +%s)

COLOUR=${COLOURS[${RANDOM} % ${#COLOURS[@]}]}

swaylock -c ${COLOUR}
