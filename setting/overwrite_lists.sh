#! /bin/sh
if [[ -x "$(command -v pip3)" ]] ; then
  echo "update pip3 list"
  pip list > ./lists/pip3
fi

if [[ -x "$(command -v brew)" ]] ; then
  echo "update brew list"
  brew ls > ./lists/brew
  echo "update brew cask list"
  brew cask ls > ./lists/brew_cask
fi

# TODO:only mac
if [[ -e ~/Library/Application\ Support/Code/User/settings.json ]]; then
  echo "update settings.json"
  cp ~/Library/Application\ Support/Code/User/settings.json ./
  code --list-extensions > ./lists/vscode_extensions
fi

if [[ "$(uname)" == 'Darwin' ]]; then
  # "${HOME}/Library/Application Support/Code/User/settings.json"
  # "${HOME}/.config/Code/User/settings.json"
else
fi
