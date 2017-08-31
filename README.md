# only to do (after installed git)
```
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/minimal/init.sh | bash
```

# @ ubuntu,debian
```sh
> apt update && apt install -y sudo git curl
> newuser="hoge"; adduser --home "/home/$newuser" $newuser && adduser $newuser sudo && su $newuser
```

# @ centos,fedora
```sh
> yum install -y sudo git passwd
> newuser="hoge"; adduser -d "/home/$newuser" $newuser && passwd $newuser && usermod -aG wheel $newuser && su $newuser
```

# @arch linux
```sh
> pacman -Syy && pacman -S --noconfirm git sudo
> echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
> newuser="hoge"; useradd -m -G wheel $newuser && passwd $newuser && su $newuser
```


# arch ringo/scientific lexaguskov/freebsd
# microsoft/windowsservercore