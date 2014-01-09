tool-setup
==========

YouCompleteMe
=============

Download the latest version of libclang.

Compile the ycm_support_libs libraries that YCM needs.

You will need to have cmake installed in order to generate the required makefiles.

You also need to make sure you have Python headers installed.

Here we'll assume you installed YCM with Vundle. That means that the top-level YCM directory is in:

        ~/.vim/bundle/YouCompleteMe
        
We'll create a new folder where build files will be placed. Run the following:
        
        cd ~
        mkdir ycm_build
        cd ycm_build
        
Now we need to generate the makefiles.

        cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/cpp
        
For those who want to use the system version of libclang, you would pass `-DUSE_SYSTEM_LIBCLANG=ON` to cmake instead of the `-DPATH_TO_LLVM_ROOT=...` flag.

Now that makefiles have been generated, simply run:

        make ycm_support_libs
