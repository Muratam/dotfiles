#! /bin/bash

mkdir -p ~/.usr/vi
cd ~/.usr/vi
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xjf vim-7.4.tar.bz2
cd vim74

./configure \
--with-features=huge \
--enable-multibyte \
--enable-luainterp=dynamic \
--enable-gpm \
--enable-cscope \
--enable-fontset \
--enable-fail-if-missing \
--prefix=~/.usr

make && make install
rm -rf ~/.usr/vi
