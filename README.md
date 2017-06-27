# dotfiles of murata
managed under homeshick

# Finally
```
curl https://raw.githubusercontent.com/Muratam/dotfiles/master/init.sh | bash
```


# how to install homeshick
```
# mac osx
$ brew install homeshick

# other os
$ git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$ alias homeshick="${HOME}/.homesick/repos/homeshick/bin/homeshick"

```

# symlink dotfiles
```
$ homeshick clone muratam/dotfiles
$ homeshick link dotfiles
```

# init enveronment once
```
$ bash ~/.homesick/repos/dotfiles/init.sh
```


# symlink vscode settings json for macosx
```
$ cd Library/Application\ Support/Code/User
$ ln -s ~/.homesick/repos/dotfiles/home/.config/Code/User/keybindings.json keybindings.json
$ ln -s ~/.homesick/repos/dotfiles/home/.config/Code/User/settings.json settings.json
```
