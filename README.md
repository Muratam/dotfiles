# dotfiles of murata
managed under homeshick

# only to do (after installed git)
```
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/master/init.sh | bash
# ... or minimal dotfiles
$ curl https://raw.githubusercontent.com/Muratam/dotfiles/minimal/init.sh | bash
```

# symlink vscode settings json for macosx
```
$ cd Library/Application\ Support/Code/User
$ ln -s ~/.homesick/repos/dotfiles/home/.config/Code/User/keybindings.json keybindings.json
$ ln -s ~/.homesick/repos/dotfiles/home/.config/Code/User/settings.json settings.json
```

-----
see http://qiita.com/sessions/items/21e3387821f76ea8f456