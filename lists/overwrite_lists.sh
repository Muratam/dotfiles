#! /bin/sh
if [[ -x "$(command -v pip3)" ]] ; then
  echo "update pip3 list"
  pip list > pip3
fi

if [[ -x "$(command -v brew)" ]] ; then
  echo "update brew list"
  brew ls > brew
  echo "update brew cask list"
  brew cask ls > brew_cask
fi

if [[ -x "$(command -v code)" ]]; then
  echo "update settings.json"
  code --list-extensions > vscode_extensions
fi
