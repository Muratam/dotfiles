# only to do (after installed git)
```
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/minimal/init.sh | bash
```

# at initial ubuntu
```
$ apt update && apt install -y sudo git curl
$ newuser="murata"
$ adduser --home "/home/$newuser" $newuser && adduser $newuser sudo && su $newuser

```
