#!/bin/bash

# Custom shell script to add features to i3status

i3status -c ~/.i3/i3status.conf | while :
do
  read line
  LG=$( xset -q | grep LED | awk '{ print $10 }' )
  case ${LG} in
    "00000000")
      dat="[{ \"full_text\": \"GB\", \"color\":\"#FF6600\" },"
      ;;
    "00001000")
      dat="[{ \"full_text\": \"BG\", \"color\":\"#CC00FF\" },"
      ;;
  esac
  echo "${line/[/${dat}}" || exit 1
done
# if [ ${LG} == "gb" ]; then
#   dat="[{ \"full_text\": \"LANG: ${LG}\", \"color\":\"#009E00\" },"
# else
#   dat="[{ \"full_text\": \"LANG: ${LG}\", \"color\":\"#C60101\" },"
# fi