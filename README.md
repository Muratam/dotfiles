# only to do (after installed git)
```sh
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/minimal/init.sh | bash
```

# Ubuntu Debian
```sh
> apt update && apt install -y sudo git curl
> newuser="hoge"; adduser --home "/home/$newuser" $newuser && adduser $newuser sudo && su $newuser
```

# CentOS Fedora ScientificLinux OracleLinux
```sh
> yum install -y sudo git passwd
> newuser="hoge"; adduser -d "/home/$newuser" $newuser && passwd $newuser && usermod -aG wheel $newuser && su $newuser
```

# ArchLinux
```sh
> pacman -Syy && pacman -S --noconfirm git sudo
> echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
> newuser="hoge"; useradd -m -G wheel $newuser && passwd $newuser && su $newuser
```

# OpenSUSE
```sh
> zypper install -y git sudo
> echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
> newuser="hoge"; useradd -m -G wheel $newuser && passwd $newuser && su $newuser
```

# FreeBSD
```sh
> pkg install -y sudo curl git bash zsh gnuls && exec bash -l
> echo "%wheel ALL=(ALL) ALL" >> /usr/local/etc/sudoers
> newuser="hgoe"; echo "$newuser::::::::zsh:" | adduser -f /dev/stdin -G wheel && passwd $newuser
```