# for mac
alias ls='ls -G -F'
alias la='ls -a'
alias ll='ls -lh'
alias l='ls'
alias du='du -h'
alias ds='du -hs *'
alias grep='grep --color=auto'
alias od='od -c'
alias g='git'
alias py='python3 -q'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
search-word(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . }
search(){ find .  -name "*$@*" | grep "$@" }
rkotlin(){ kotlinc -include-runtime -d app.jar $1;kotlin app.jar; }

export rmate='-R 52698:localhost:52698'
export PS1="\[\e[30m\][\w]\n\[\e[36m\]../\W/ \$ \[\e[0m\]"
export LESS='-i -M -R -S -W -z-4 -x4 -F'

# for mac jupyter note
export PYTHONPATH=$PYTHONPATH:~/python/library

# python virtual env
[[ -d ~/.py_env ]] && source ~/.py_env/bin/activate

# ruby rbenv
[[ -d ~/.rbenv  ]] && export PATH=${HOME}/.rbenv/bin:${PATH} && eval "$(rbenv init -)"

rsyncPullTwitterImages(){ rsync --delete -avz -e ssh murata@kmc.gr.jp:/home/murata/private_html/images/twitter/ /Users/murata/Library/Mobile\ Documents/com~apple~CloudDocs/Picture/twitter/; };
rsyncPushTwitterImages(){ rsync --delete -avz /Users/murata/Library/Mobile\ Documents/com~apple~CloudDocs/Picture/twitter/ -e ssh murata@kmc.gr.jp:/home/murata/private_html/images/twitter/; };
