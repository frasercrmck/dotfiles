tool-setup
==========

YouCompleteMe
-------------

Download the latest version of libclang. On Arch you can do:

        pacman -S clang

Compile the ycm_support_libs libraries that YCM needs.

You will need to have cmake installed in order to generate the required makefiles.

You also need to make sure you have Python headers installed.

Here we'll assume you installed YCM with Vundle. That means that the top-level YCM directory is in:

        ~/.vim/bundle/YouCompleteMe
        
We'll create a new folder where build files will be placed. Run the following:
        
        cd ~
        mkdir ycm_build
        cd ycm_build
        
Now we need to generate the makefiles. On Arch you can do:

        cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/cpp
        
If not using the system libclang, you would pass `--DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir` to cmake instead.

Now that makefiles have been generated, simply run:

        make ycm_support_libs
