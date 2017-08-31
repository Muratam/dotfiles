#! /bin/bash
# iikanji command lists
declare recommendeds=( git tmux zsh vim tig tree wget unzip less )
declare convinients=( jq rlwrap highlight thefuck sshfs )
declare brewtaps=( caskroom/cask caskroom/fonts homebrew/core sanemat/font )
declare brewinstalls=( # huge commands for mac
  moreutils pandoc imagemagick docker
  cmake nim node # eigen boost
)
declare brewcasks=( # cask commands
  firefox hammerspoon thunderbird google-japanese-ime visual-studio-code
  kindle osxfuse gyazo google-chrome font-noto-sans-cjk-jp skype
)


execable(){ [[ -x "$(command -v $1)" ]] || [[ "$(command -v $1)" != "" ]] ; }
green(){ echo "`tput setaf 2`$@`tput sgr0`"; }
yellow(){ echo "`tput setaf 3`$@`tput sgr0`"; }
installlist(){ echo "install `tput setaf 3`$@ `tput sgr0`" ; }

# if mac,install brew
if [[ "$(uname)" == 'Darwin' ]] && [[ "$(command -v brew)" == "" ]] ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# get package manager
if execable brew; then manager="brew install"
elif execable apt; then manager="sudo apt install -y"
elif execable yum; then
  manager="sudo yum install -y";
  sudo yum install -y epel-release
elif execable pacman; then manager="sudo pacman install"
else echo "no package manager"; exit 1
fi

# install all recommended commands
installlist ${recommendeds[@]}
for cmd in ${recommendeds[@]} ; do
  [[ "$(command -v $cmd)" == "" ]] && yellow $cmd && $manager $cmd
done
green installed

# install all convinient commands
installlist ${convinients[@]}
#echo "ok ? [yn]" && read input_v && [[ $input_v == "n" ]] && exit 1
for cmd in ${convinients[@]} ; do
  [[ "$(command -v $cmd)" == "" ]] && yellow $cmd && $manager $cmd
done
green installed


#### brew ####################################################

# if not brew finish here
if [[ "$(command -v brew)" == "" ]]; then
  green "finished"
  exit 0
fi

echo "brew tap"
for cmd in ${brewtaps[@]} ; do
  brew tap $cmd
done

installlist ${brewinstalls[@]}
brewlist="$(brew list)"
for cmd in ${brewinstalls[@]} ; do
  [[ ! $brewlist =~ $cmd ]]  && yellow $cmd && brew install $cmd
done
green installed

installlist ${brewcasks[@]}
brewcasklist="$(brew cask list)"
for cmd in ${brewcasks[@]} ; do
  [[ ! $brewcasklist =~ $cmd ]]  && yellow $cmd && brew cask install $cmd
done
green installed
