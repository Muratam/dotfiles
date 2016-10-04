# for mac ?
alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='ls -l'
alias l='ls'
alias grep='grep --color=auto'
alias g='git'
alias py='python3'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
alias vscode='open -a Visual\ Studio\ Code'
rkotlin(){ kotlinc -include-runtime -d app.jar $1;kotlin app.jar; }
gr(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" ./ }
fin(){ find ./  -name "*$@*" | grep "$@" }

export kmc="murata@kmc.gr.jp"
export mars='murata@49.212.155.232'
export PS1="\[\e[30m\][\w]\n\[\e[36m\]../\W/ \$ \[\e[0m\]"

#for mac jupyter note
export PYTHONPATH=$PYTHONPATH:~/pylib
export PATH=$PATH:~/node_modules/.bin:~/ruby/gems/bin:~/.local/bin
export PATH=$PATH:~/perl5/bin:~/apt:~/ultrapiet
export PERL5LIB=$PERL5LIB:~/perl5/lib/perl5
export GEM_HOME=~/ruby/gems
export PYTHONPATH=${PYTHONPATH}:/home/murata/python/pepper/naoqi
export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:/home/murata/python/pepper/naoqi
unset MAILCHECK
