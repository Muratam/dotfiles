#!/usr/bin/env bash


# zsh
[[ ! -e ~/.zsh ]] && mkdir ~/.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions


# vim
# plug_file="${HOME}/.vim/autoload/plug.vim"
# if [[ ! -f $plug_file ]];then
#   curl -Lo $plug_file --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi