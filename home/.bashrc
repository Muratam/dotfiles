# if zsh exists, force bash -> zsh, without chsh
([[ $0 = "bash" ]] || [[ $0 = "-bash" ]] || [[ $0 = "su" ]]  || [[ $0 = "-su" ]] ) && [[ $SHLVL -le 2 ]] && [[ -x "$(command -v zsh)" ]] &&  exec zsh -l
# use xterm-256
[[ $TERM = "xterm" ]] && export TERM='xterm-256color'
execable(){ [[ -x "$(command -v $1)" ]] || [[ "$(command -v $1)" != "" ]] ; }


###################
### SET ALIASES ###
###################
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color=auto -F'
  execable gnuls && alias ls='gnuls --color=auto -F'
fi
# override aliases
alias cp='cp -i'
alias crontab='crontab -i'
alias du='du -h'
alias od='od -c'
alias su='su -l'
alias grep='grep --color=auto'

# aliases
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -lah'
alias l='ls'
alias g='git'
alias t='tmux'
alias ta='tmux a'
alias ds='du -hs * 2> /dev/null'
alias py='python3 -q'
alias pip="pip3"
alias untar="tar xf"
alias tree='tree -CF'
alias pe='perl -pe'
search-word(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . ; }
search(){ find . -follow -name "*$@*" 2> /dev/null | grep "$@" ; }
lns(){ lla | grep -- " -> " | awk '{printf "%-15s %s %s\n",$9,$10,$11}' ; }

# benri commands
execable highlight && alias ca='highlight -O xterm256 -s rdark --force'
execable tldr && alias f='tldr $(fc -ln -1 | tail -n 1 | p 1)'
[[ "$(command -v tac)" == "" ]] && alias tac='tail -r'

################################
### SET ENVIRONMENT VARIABLE ###
################################
export LESS='-imMRSF'
export LANG=ja_JP.UTF-8
unset MAILCHECK

export-path(){ [[ -d $1 ]] && export PATH=$1:${PATH}; }
# node modules without sudo
export-path ~/node_modules/.bin
# pip modules without sudo
export-path ~/.local/bin
# /usr/bin や /bin よりも /usr/local/bin を優先
export-path /usr/local/bin
# local installs
export-path ~/.usr/bin

# for isucon
export-path ~/bin
[[ -f ~/env.sh ]] && source env.sh
alias dstat="dstat -t -a"
alias alp="alp --sum -r --aggregates='/keyword/.*' -f" # accsess.log
alias pt-query-digest="pt-query-digest --limit 10" # slow.log

# homeshick
[[ -d ~/.homesick/repos/homeshick ]] && alias homeshick="${HOME}/.homesick/repos/homeshick/bin/homeshick"

