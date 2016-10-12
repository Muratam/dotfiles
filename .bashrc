# for mac ?
alias ls='ls -G -F'
alias la='ls -a'
alias ll='ls -l'
alias l='ls'
alias grep='grep --color=auto'
alias g='git'
alias py='python3'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
rkotlin(){ kotlinc -include-runtime -d app.jar $1;kotlin app.jar; }
gr(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" ./ }
fin(){ find ./  -name "*$@*" | grep "$@" }

export kmc="murata@kmc.gr.jp"
export mars='murata@49.212.155.232'
export PS1="\[\e[30m\][\w]\n\[\e[36m\]../\W/ \$ \[\e[0m\]"

# for mac jupyter note
export PYTHONPATH=$PYTHONPATH:~/python/library

# python virtual env
[[ -d ~/.py_env ]] && source ~/.py_env/bin/activate

# ruby rbenv
[[ -d ~/.rbenv  ]] && export PATH=${HOME}/.rbenv/bin:${PATH} && eval "$(rbenv init -)"

rsyncPullTwitterImages(){ rsync --delete -avz -e ssh murata@kmc.gr.jp:/home/murata/private_html/images/twitter/ /Users/murata/Library/Mobile\ Documents/com~apple~CloudDocs/Picture/twitter/ }
rsyncPushTwitterImages(){ rsync --delete -avz /Users/murata/Library/Mobile\ Documents/com~apple~CloudDocs/Picture/twitter/ -e ssh murata@kmc.gr.jp:/home/murata/private_html/images/twitter/ }
