# tool-setup

First Things First
==================

Symlink All The Things
----------------------

        ./setup.sh
        
Setting Up Vim
==============

Vundle
------

        ./install_vundle.sh

YouCompleteMe
-------------

Download the latest version of libclang. On Arch you can do:

        pacman -S clang

Compile the ycm_support_libs libraries that YCM needs:

        ./build_ycm.sh
