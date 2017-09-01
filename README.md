# only to do (after installed git)
```sh
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/minimal/init.sh | bash
```

# Ubuntu Debian
```sh
> apt update && apt install -y sudo git curl
> newuser="hoge"; adduser --home "/home/$newuser" $newuser && adduser $newuser sudo && su $newuser
```

# Fedora RHEL CentOS {Scientific,Oracle,Amazon} Linux
```sh
> yum install -y sudo git passwd
> echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
> newuser="hoge"; adduser -d "/home/$newuser" $newuser && passwd $newuser && usermod -aG wheel $newuser && su $newuser
```

# ArchLinux OpenSUSE Gentoo
```sh
# ArchLinux
> pacman -Syy && pacman -S --noconfirm git sudo
# OpenSUSE
> zypper install -y git sudo
# Gentoo
> emerge-webrsync && emerge sudo git curl
```

```sh
> echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
> newuser="hoge"; useradd -m -G wheel $newuser && passwd $newuser && su $newuser
```

# FreeBSD
```sh
> pkg install -y sudo curl git bash gnuls
> echo "%wheel ALL=(ALL) ALL" >> /usr/local/etc/sudoers
> set newuser="hoge"; echo $newuser"::::::::bash:" | adduser -f /dev/stdin -G wheel && passwd $newuser && su $newuser
```

