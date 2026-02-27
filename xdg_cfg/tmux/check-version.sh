#!/usr/bin/env bash

# Compare the current tmux version against a given version.
# Exit: 0 if comparison is true, 1 if false

set -euo pipefail

usage() {
  echo "usage: $0 <operator> <version>" >&2
  echo "operators: < <= == >= >" >&2
}

if [[ ${1:-} == "-h" || ${1:-} == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

operator="$1"
target_version="$2"

# Extract tmux version (e.g., "tmux 3.3a" -> "3.3a")
current_version=$(tmux -V | sed 's/^tmux //')

# Compare two version strings
# Returns: -1 if v1 < v2, 0 if v1 == v2, 1 if v1 > v2
compare_versions() {
  local v1="$1"
  local v2="$2"

  # Strip trailing letters (e.g., "3.3a" -> "3.3") and save them
  local v1_suffix="${v1##*[0-9]}"
  local v2_suffix="${v2##*[0-9]}"
  v1="${v1%[a-zA-Z]*}"
  v2="${v2%[a-zA-Z]*}"

  # Split into components
  IFS='.' read -ra v1_parts <<< "$v1"
  IFS='.' read -ra v2_parts <<< "$v2"

  # Compare numeric parts
  local max_len=$(( ${#v1_parts[@]} > ${#v2_parts[@]} ? ${#v1_parts[@]} : ${#v2_parts[@]} ))
  for ((i = 0; i < max_len; i++)); do
    local p1="${v1_parts[i]:-0}"
    local p2="${v2_parts[i]:-0}"
    if ((p1 < p2)); then
      echo -1
      return
    elif ((p1 > p2)); then
      echo 1
      return
    fi
  done

  # Numeric parts equal, compare suffixes (no suffix < a < b < ...)
  # A letter suffix indicates a patch release, so 3.6a > 3.6
  if [[ -z "$v1_suffix" && -n "$v2_suffix" ]]; then
    echo -1
    return
  elif [[ -n "$v1_suffix" && -z "$v2_suffix" ]]; then
    echo 1
    return
  elif [[ "$v1_suffix" < "$v2_suffix" ]]; then
    echo -1
    return
  elif [[ "$v1_suffix" > "$v2_suffix" ]]; then
    echo 1
    return
  fi

  echo 0
}

result=$(compare_versions "$current_version" "$target_version")

case "$operator" in
  '<')
    [[ "$result" -eq -1 ]] && exit 0 || exit 1 ;;
  '<=')
    [[ "$result" -le 0 ]] && exit 0 || exit 1 ;;
  '==')
    [[ "$result" -eq 0 ]] && exit 0 || exit 1 ;;
  '>=')
    [[ "$result" -ge 0 ]] && exit 0 || exit 1 ;;
  '>')
    [[ "$result" -eq 1 ]] && exit 0 || exit 1 ;;
  *)
    echo "error: invalid operator: $operator" >&2
    usage
    exit 1
    ;;
esac
