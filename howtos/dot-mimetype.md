Getting DOT files to open with xdot
===================================

Sigh. What a pain! Most systems think that `.dot` files are ms-word files. To fix this, do the following:

Install the `perl-file-mimeinfo` package

Copy the following into `/usr/share/mime/packages`:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="text/vnd.graphviz">
    <glob weight="100" pattern="*.dot"/>
  </mime-type>
</mime-info>
```

_Note: apparently this is only for system-wide configuration, but I couldn't get it to work in `~/.local/share/mime`_

Run `update-mime-database /usr/share/mime`

**Hint**: Run `xdg-mime query filetype foo.dot` to see if it's working.
