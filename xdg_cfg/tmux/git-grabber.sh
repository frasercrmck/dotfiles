main() {
  local command="$1"
  shift

  pattern=""
  filter=""
  placeholder=""
  tag=""
  case "$command" in
  commits)
    # gitgrabber.commitsurl - https://www.github.com/<user>/<repo>/commit/$commit
    pattern="\b[a-f0-9]\{5,40\}\b"
    filter="$pattern"
    placeholder=commit
    tag=commitsurl
    ;;
  issues)
    # gitgrabber.issuesurl - https://www.github.com/<user>/<repo>/issues/$issue
    pattern="#[0-9]\+"
    filter="[0-9]\+"
    placeholder=issue
    tag=issuesurl
    ;;
  *)
    echo "Unknown command: $command"
    exit
    ;;
  esac

  # Grab the URL we're meant to open
  exit_code=0
  url=$(git config --local gitgrabber.$tag) || exit_code=$?
  if [ $exit_code -ne 0 ]; then
    echo unused | fzf -q "<error: could not read gitgrabber.$tag from config>"
    return
  fi

  # 1. Grab the current pane's output
  # 2. Search for the pattern, print the whole line (for context)
  # 3. Enter fzf to select one, with jump mode enabled
  buffer=$(tmux capture-pane -p | grep "$pattern" | fzf --bind load:jump,jump:accept,jump-cancel:abort)

  if [ -z "$buffer" ]; then
    return
  fi

  # 1. Grep again for the pattern, only printing the match
  # 2. Filter the output based on the command (e.g., #100 -> 100 for issues)
  data=$(echo $buffer | grep -o "$pattern" | grep -o "$filter")

  # Replace the URL containing the placeholder with the filtered commit/issue
  
  url=`echo $url | sed "s/\\$$placeholder/$data/g"` || exit_code=$?
  if [ $exit_code -ne 0 ]; then
    echo unused | fzf -q "<error: could not format URL to open>"
    return
  fi

  xdg-open "$url"
}

main "$@"
