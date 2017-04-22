#!/usr/bin/env bash

cd `dirname $0`
for f in .*;do
    if  [[ $f =~ \.[a-zA-Z0-9]+ ]] && [ -f $f ];then
        ln -s ~/dotfiles/$f ~/$f
        echo "linked" $f
    fi
done

mkdir -p ~/.config/micro
ln -s ~/dotfiles/.config/micro/bindings.json ~/.config/micro/bindings.json

if [ ! -e ~/.zsh ];then
  mkdir ~/.zsh
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions


