#!/bin/bash

# Starts up nm-applet if it exists

if command -v nm-applet > /dev/null 2>&1; then
  nm-applet
fi
