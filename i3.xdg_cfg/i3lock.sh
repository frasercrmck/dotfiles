#!/bin/bash

COLOURS=(
  DAB84A # Yellow
  DA704A # Red
  67B5D1 # Turquoise
  A4BC62 # Green
  822C6C # Purple
)

RANDOM=$$$(date +%s)

COLOUR=${COLOURS[${RANDOM} % ${#COLOURS[@]}]}

i3lock -c ${COLOUR}
