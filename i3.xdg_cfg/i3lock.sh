#!/bin/bash

COLOURS=(
  DAB84A # Yellow
  DA704A # Red
  67B5D1 # Turquoise
  A4BC62 # Green
  822C6C # Purple
  555577 # Blue
  113388 # Blue 2
  DDAACC # Pinky
  775577 # Purpley
  ADD8B8 # Greeny
)

RANDOM=$$$(date +%s)

COLOUR=${COLOURS[${RANDOM} % ${#COLOURS[@]}]}

i3lock -c ${COLOUR}
