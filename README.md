# dotfiles of murata
managed under homeshick

# only to do (after installed git)
```
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/master/init.sh | bash
```

or (shortly)

```
$ curl -L muratam.0am.jp/init.sh
```

# symlink vscode settings json for macosx
```
$ cd Library/Application\ Support/Code/User
$ ln -s ~/.homesick/repos/dotfiles/home/.config/Code/User/keybindings.json keybindings.json
$ ln -s ~/.homesick/repos/dotfiles/home/.config/Code/User/settings.json settings.json
```
