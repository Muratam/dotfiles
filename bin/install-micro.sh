#! /bin/sh
if [ ! $1 ];then
  echo "Usage :\n  \$${0} https://github.com/zyedidia/micro/releases/download/nightly/micro-1.1.5-dev.144-{os}.tar.gz"
  echo "  os is (linux-arm linux64 linux32 netbsd64 netbsd32 freebsd64 freebsd32 openbsd64 openbsd32 osx win64 win32)"
  exit ;
fi

mkdir ~/install_micro
cd ~/install_micro
wget $1
tarname=`ls`
tar xfvz $tarname
echo $tarname
echo ls `ls`
echo pwd `pwd`
rm $tarname
sudo cp micro*/micro /usr/local/bin/
cd ~/
rm -r ~/install_micro