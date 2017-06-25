#! /bin/sh
update_vscode_background(){
  if [[ "$(uname)" == 'Darwin' ]]; then
    echo "  .composite.panel.integrated-terminal{ background-image: url('$1');background-position: center center; background-repeat: no-repeat;background-attachment: fixed;  background-size: cover; }" >> /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/out/vs/workbench/electron-browser/workbench.main.css
  else
    echo "not supported os (now only for macosx)"
  fi
}
update_vscode_background "${HOME}/icloud/pics/background/sagisawa.jpg"
