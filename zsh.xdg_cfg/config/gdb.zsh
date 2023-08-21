export GDBHISTFILE="$XDG_DATA_HOME"/gdb/history

# Ensure the GDBHISTFILE can be written
[ ! -d $(dirname $GDBHISTFILE) ] && mkdir -p $(dirname $GDBHISTFILE)
