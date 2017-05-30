
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
  alias hl-chrome='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --headless --disable-gpu'
  # --print-to-pdf,--dump-dom,--screenshot
else
  alias ls='ls --color=auto -F'
fi

alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -lah'
alias l='ls'
alias cp='cp -i'
alias du='du -h'
alias ds='du -hs *'
alias grep='grep --color=auto'
alias od='od -c'
alias g='git'
alias py='python3 -q'
alias tar.gz="tar xfvz"
alias tree='tree -CF'
alias htree='tree -hF'
alias rl='rlwrap -pYellow -ic'
alias pe='perl -pe'
if which rlwrap > /dev/null ;then alias sftp="rl sftp";fi

search-word(){
  grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" .
}
search(){
  find . -follow -name "*$@*" 2> /dev/null | grep "$@"
}
# export rmate='-R 52698:localhost:52698'
# export PS1="\[\e[32m\][\w]\n\[\e[36m\]\W \$ \[\e[0m\]"
export LESS='-i -M -R -S -W -z-4 -x4 -F'
export LANG=ja_JP.UTF-8


# python virtual env
[[ -d ~/.py_env ]] && source ~/.py_env/bin/activate
# ruby rbenv
[[ -d ~/.rbenv  ]] && export PATH=${HOME}/.rbenv/bin:${PATH} && eval "$(rbenv init -)"
# rust cargo
[[ -d ~/.cargo  ]] && export PATH=${HOME}/.cargo/bin:${PATH} && export RUST_SRC_PATH=${HOME}/.multirust/toolchains/beta-x86_64-apple-darwin/lib/rustlib/src/rust/src

# dlang workspace-d
[[ -d ~/codes/dlang/workspace-d ]] && export PATH=$PATH:~/codes/dlang/workspace-d/bin

if [[ "$(hostname)" == "ringo" ]]; then
  export PATH=$PATH:${HOME}/node_modules/.bin:${HOME}/ruby/gems/bin:${HOME}/.local/bin
  export PATH=$PATH:${HOME}/perl5/bin:${HOME}/apt:${HOME}/ultrapiet
  export PERL5LIB=$PERL5LIB:${HOME}/perl5/lib/perl5
  export GEM_HOME=${HOME}/ruby/gems
  export PYTHONPATH=${PYTHONPATH}:${HOME}/python/pepper/naoqi
  export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${HOME}/python/pepper/naoqi
  unset MAILCHECK
fi

export PYTHONPATH=${PYTHONPATH}:${HOME}/dotfiles/lib

if [[ $0 = "-bash" && `which zsh` ]]; then zsh;exit; fi