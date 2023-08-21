# We also need this file in case ZDOTDIR is already set when launching zsh, in
# which case this file is sourced and its skip_global_compinit is taken by /etc/zsh/zshrc

# I'll do my own compinit, thank you
skip_global_compinit=1
