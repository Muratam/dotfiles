#! /bin/bash
# iikanji command lists
declare recommendeds=( git tmux zsh vim tig tree wget unzip less )
declare convinients=( jq rlwrap highlight thefuck )
execable(){ [[ -x "$(command -v $1)" ]] || [[ "$(command -v $1)" != "" ]] ; }
green(){ echo "`tput setaf 2`$@`tput sgr0`"; }
yellow(){ echo "`tput setaf 3`$@`tput sgr0`"; }
installlist(){ echo "install `tput setaf 3`$@ `tput sgr0`" ; }

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
echo "ok ? [yn]" && read input_v && [[ $input_v == "n" ]] && exit 1
for cmd in ${convinients[@]} ; do
  [[ "$(command -v $cmd)" == "" ]] && yellow $cmd && $manager $cmd
done
green installed