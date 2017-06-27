#!/bin/bash

COLOURS=(
  DAB84A # Yellow
  DA704A # Red
  F17A64 # Red2
  67B5D1 # Turquoise
  A4BC62 # Green
  822C6C # Purple
  555577 # Blue
  63CEE7 # Blue2
  DDAACC # Pinky
  775577 # Purpley
  AE69E7 # Purpley2
  ADD8B8 # Greeny
  8FF17B # Greeny2
  CCF1D4 # Greeny3
)

RANDOM=$$$(date +%s)

COLOUR=${COLOURS[${RANDOM} % ${#COLOURS[@]}]}

i3lock -c ${COLOUR}
