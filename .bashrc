
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color=auto -F'
fi

alias la='ls -a'
alias ll='ls -lh'
alias l='ls'
alias du='du -h'
alias ds='du -hs *'
alias grep='grep --color=auto'
alias od='od -c'
alias g='git'
alias py='python3 -q'
alias tar.gz="tar xfvz"
search-word(){ 
  grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . 
}
search(){ 
  find . -follow -name "*$@*" 2> /dev/null | grep "$@" 
}
export rmate='-R 52698:localhost:52698'
export PS1="\[\e[30m\][\w]\n\[\e[36m\]../\W/ \$ \[\e[0m\]"
export LESS='-i -M -R -S -W -z-4 -x4 -F'

# for jupyter note
[[ -d ~/python/library ]] && export PYTHONPATH=$PYTHONPATH:~/python/library
# python virtual env
[[ -d ~/.py_env ]] && source ~/.py_env/bin/activate
# ruby rbenv
[[ -d ~/.rbenv  ]] && export PATH=${HOME}/.rbenv/bin:${PATH} && eval "$(rbenv init -)"
# dlang workspace-d
[[ -d ~/codes/dlang/workspace-d ]] && export PATH=$PATH:~/codes/dlang/workspace-d/bin

if [[ "$(hostname)" == "ringo" ]]; then
  export PATH=$PATH:~/node_modules/.bin:~/ruby/gems/bin:~/.local/bin
  export PATH=$PATH:~/perl5/bin:~/apt:~/ultrapiet
  export PERL5LIB=$PERL5LIB:~/perl5/lib/perl5
  export GEM_HOME=~/ruby/gems
  export PYTHONPATH=${PYTHONPATH}:/home/murata/python/pepper/naoqi
  export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:/home/murata/python/pepper/naoqi
  unset MAILCHECK
fi