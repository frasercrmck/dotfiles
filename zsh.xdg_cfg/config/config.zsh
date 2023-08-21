# Misc
# ---------------------------
setopt ignoreeof            # Prevent Ctrl-D from exiting
setopt promptsubst          # Allow parameter, command, etc, in prompt
setopt transient_rprompt    # Hide RPROMPT after cmdline is executed
setopt interactivecomments  # Comment out my interactive prompt
setopt magicequalsubst      # Expand ~ even after =
setopt extendedglob         # Extended globbing

# History & History Expansion
# ---------------------------
setopt extendedhistory      # Save timestamps in history
setopt histignoredups       # Ignore consecutive dups
setopt histfindnodups       # Backwards search produces diff result each time
setopt histreduceblanks     # Compact consecutive white space chars
setopt incappendhistory     # Incrementally add items to HISTFILE
# setopt share_history      # Share history between sessions

HISTSIZE=500000
SAVEHIST=500000

HISTFILE="$XDG_STATE_HOME"/zsh/history
[ ! -d "$XDG_STATE_HOME"/zsh ] && mkdir -p "$XDG_STATE_HOME"/zsh
