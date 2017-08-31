# only to do (after installed git)
```
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/minimal/init.sh | bash
```

# @ ubuntu,debian
```
# apt update && apt install -y sudo git curl
# newuser="hoge"; adduser --home "/home/$newuser" $newuser && adduser $newuser sudo && su $newuser
```

# @ centos
```
# yum install -y sudo git
# visudo # wheel ALL=(ALL) NOPASSWD: ALL # comment out this
# newuser="hoge"; adduser -d "/home/$newuser" $newuser && usermod -aG wheel $newuser && su $newuser
```
