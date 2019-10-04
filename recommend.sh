#! /bin/bash
# iikanji command lists
cd ~/
declare recommendeds=( git tmux zsh vim tig tree wget unzip less )
declare convinients=( highlight vnstat nmap )
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
elif execable apt   ; then manager="sudo apt-get install -y"
elif execable pacman; then manager="sudo pacman -S --noconfirm" # ArchLinux
elif execable zypper; then manager="sudo zypper install -y" # OpenSUSE
elif execable emerge; then manager="sudo emerge" # Gentoo
elif execable pkg   ; then manager="sudo pkg install -y" # FreeBSD
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
for cmd in ${convinients[@]} ; do
  [[ "$(command -v $cmd)" == "" ]] && yellow $cmd && $manager $cmd
done
green installed


### isucon install
declare isucons=( htop dstat glances )
installlist ${isucons[@]}
for cmd in ${isucons[@]} ; do
  [[ "$(command -v $cmd)" == "" ]] && yellow $cmd && $manager $cmd
done
green installed

# isucon :: netdata (localhost:19999)
echo "install `tput setaf 3` netdata `tput sgr0`"
yes | bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh)
green installed

# isucon :: alp
echo "install `tput setaf 3` alp `tput sgr0`"
[[ ! -d ~/bin/tmp ]] && mkdir -p ~/bin/tmp && cd ~/bin/tmp
wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin
green installed

yellow "use zsh as default"
execable zsh && which zsh | sudo chsh $USER
green installed

# isucon :: pt-query-digest
echo "install `tput setaf 3` pt-query-digest `tput sgr0`"
if execable yum; then
  sudo yum install -y https://www.percona.com/downloads/percona-toolkit/2.2.17/RPM/percona-toolkit-2.2.17-1.noarch.rpm
elif execable apt; then
  wget https://www.percona.com/downloads/percona-toolkit/3.0.4/binary/debian/xenial/x86_64/percona-toolkit_3.0.4-1.xenial_amd64.deb
  sudo apt install libdbd-mysql-perl libdbi-perl libio-socket-ssl-perl libnet-ssleay-perl
  sudo dpkg -i percona-toolkit_3.0.4-1.xenial_amd64.deb
fi
green installed

# isucon::schemaspy
yellow "install schemaspy"
if execable yum; then
  sudo yum install -y java-1.8.0-openjdk
  sudo yum install -y java-1.8.0-openjdk-devel
elif execable apt; then 
  sudo apt install default-jre
fi
wget https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar
mv schemaspy-6.1.0.jar schemaspy.jar
mkdir schemaspy
mv schemaspy.jar schemaspy
if execable yum; then
  cd schemaspy
  wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.17.tar.gz
  tar xzvf *.tar.gz
  cp mysql*/*.jar ./
  # java -jar schemaspy.jar -dp mysql*.jar -...
  cd ..
elif execable apt; then 
  # java -jar schemaspy.jar -t mysql -dp /usr/share/java/mysql-connector-java.jar -db isucari -host 127.0.0.1 -port 3306 -s isucari -u isucari -p isucari -o schemaspy
  sudo apt-get install libmysql-java
fi

green installed
