#!/usr/bin/env bash

# git check
if [[ ! -x $(command -v git) ]]; then
  echo "please install git !! "
  exit
fi

# homeshick and link
if [[ ! -x $(command -v homeshick) ]]; then
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  git clone -b minimal https://github.com/Muratam/dotfiles.git $HOME/.homesick/repos/dotfiles_minimal
fi

# zsh
[[ ! -e ~/.zsh ]] && mkdir ~/.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions


# vim
plug_file="${HOME}/.vim/autoload/plug.vim"
if [[ ! -f $plug_file ]];then
  curl -Lo $plug_file --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

${HOME}/.homesick/repos/homeshick/bin/homeshick link dotfiles_minimal

# install recommended command
sh ${HOME}/.homesick/repos/dotfiles_minimal/recommend.sh