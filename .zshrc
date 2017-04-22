source ~/.bashrc

export LANG=ja_JP.UTF-8
autoload -U compinit; compinit
zstyle ':completion:*' list-colors ''
setopt auto_cd
setopt auto_param_slash
setopt auto_menu
setopt complete_in_word
setopt mark_dirs
setopt list_packed

# PROMPT変数で変数参照を可能に
setopt prompt_subst
PROMPT="%F{green}[%~ @%m]
%(?!%F{cyan}%1~ %(!.#.$)!%F{red}%1~ !) %f"

autoload -Uz zmv
alias mmv='noglob zmv -W'
alias tree='tree -CF'
alias htree='tree -hF'
alias rl='rlwrap -pYellow -ic'

# cd + tab -> directory history
setopt auto_pushd
setopt pushd_ignore_dups
# extended glob (pattern match)
setopt extended_glob
# when command in history, delete old history
setopt hist_ignore_all_dups
# start with space, not save in history
setopt hist_ignore_space
# completion files
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ctrl-w -> delete until '/' treat these words as normal chalacters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# history
export HISTFILE=${HOME}/.zsh_hist
export HISTSIZE=2000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する


# command color
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# command hist color
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#fpath=(~/.zsh/zsh-completions/src $fpath)

# 実行時間が3秒以上ならtime表示
REPORTTIME=3
