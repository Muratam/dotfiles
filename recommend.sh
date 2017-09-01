#! /bin/bash
# iikanji command lists
declare recommendeds=( git tmux zsh vim tig tree wget unzip less )
declare convinients=( highlight )
execable(){ [[ -x "$(command -v $1)" ]] || [[ "$(command -v $1)" != "" ]] ; }
green(){ echo "`tput setaf 2`$@`tput sgr0`"; }
yellow(){ echo "`tput setaf 3`$@`tput sgr0`"; }
installlist(){ echo "install `tput setaf 3`$@ `tput sgr0`" ; }

# get package manager
if execable brew; then manager="brew install"
elif execable yum; then
  manager="sudo yum install -y";
  sudo yum install -y epel-release
  sudo yum update -y vim-minimal
elif execable apt   ; then manager="sudo apt install -y"
elif execable pacman; then manager="sudo pacman -S --noconfirm" # ArchLinux
elif execable zypper; then manager="sudo zypper install -y" # OpenSUSE
elif execable pkg   ; then manager="sudo pkg install -y" # FreeBSD
elif execable emerge; then manager="sudo emerge" # Gentoo
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
