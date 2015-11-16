# These functions mimic csh setenv and unsetenv functions, allowing minimal
# cross-compatibility.
# TODO: setenv does not necessarily take a value: 'setenv VAR' sets VAR to null
# These were taken from here: https://news.ycombinator.com/item?id=4201636

setenv () {
    if [ "x$1" = "x" ] ; then
      echo "$0: environment variable name required" >&2
    elif [ "x$2" = "x" ] ; then
      echo "$0: environment variable value required" >&2
    else
      export $1=$2
    fi
}

unsetenv () {
    if [ "x$1" = "x" ] ; then
      echo "$0: environment variable name required" >&2
    else
      unset $1
    fi
}
