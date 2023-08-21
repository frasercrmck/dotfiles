zsh_add_file() {
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

zsh_add_plugin() {
  plugin_name=${1#*/}
  if [ ! -d "$ZDOTDIR/plugins/$plugin_name" ]; then
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$plugin_name"
  fi
  zsh_add_file "plugins/$plugin_name/$plugin_name.plugin.zsh" || \
  zsh_add_file "plugins/$plugin_name/$plugin_name.zsh"
}

zsh_load_configs() {
  if [ -d "$ZDOTDIR/config" ]; then
    if [ -d "$ZDOTDIR/config/pre" ]; then
      for config in "$ZDOTDIR/config"/pre/**/*~*.zwc(N-.); do
        source $config
      done
    fi

    for config in "$ZDOTDIR/config"/**/*(N-.); do
      case "$config" in
      "$ZDOTDIR/config"/(pre|post)/*|*.zwc)
        :
        ;;
      *)
        source $config
        ;;
      esac
    done

    if [ -d "$ZDOTDIR/config/post" ]; then
      for config in "$ZDOTDIR/config"/post/**/*~*.zwc(N-.); do
        source $config
      done
    fi
  fi
}