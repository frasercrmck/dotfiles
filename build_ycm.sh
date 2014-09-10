#!/bin/bash -ex

mkdir ycm
mkdir ycm/ycm_build

cd ycm/ycm_build

cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

make -j9 ycm_support_libs
