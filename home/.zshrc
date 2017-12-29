source ~/.bashrc

autoload -U compinit; compinit
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' special-dirs true # ..を補完
setopt auto_cd
setopt auto_param_slash
setopt auto_menu
setopt complete_in_word
setopt complete_aliases
setopt mark_dirs
setopt list_packed

# PROMPT変数で変数参照を可能に
setopt prompt_subst

autoload -Uz zmv
alias zmv='noglob zmv -W'

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
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # --prefix=/usr などの補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt brace_ccl # 例 : mkdir {1-3} で フォルダ1, 2, 3を作れる
# 今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..




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
# REPORTTIME=3

# vcs
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# git prompt
zstyle ':vcs_info:*' formats '%F{blue}%b%f'
zstyle ':vcs_info:*' actionformats '%F{blue}%b%f(%F{red}%a%f)'
add-zsh-hook precmd vcs_info

_vcs_git_indicator() {
  typeset -A git_info
  local git_indicator git_status
  git_status=("${(f)$(git status --porcelain --branch 2> /dev/null)}")
  (( $? == 0 )) && {
    git_info[branch]="${${git_status[1]}#\#\# }"
    shift git_status
    git_info[changed]=${#git_status:#\?\?*}
    git_info[untracked]=$(( $#git_status - ${git_info[changed]} ))
    git_indicator=""
    (( $git_info[changed] != 0 )) && git_indicator+="%{%F{blue}%}M${git_info[changed]}%{%f%} "
    (( $git_info[untracked] != 0 )) && git_indicator+="%{%F{blue}%}?${git_info[untracked]} %{%f%}"
    #git_indicator+="%{%F{blue}%}${git_info[branch]}%{%f%}"
  }
  _vcs_git_indicator="${git_indicator}"
}
add-zsh-hook precmd _vcs_git_indicator
PROMPT="%F{green}[%~ @%m] \$vcs_info_msg_0_ \$_vcs_git_indicator
%(?!%F{cyan}%1~ %(!.#.$)!%F{red}%1~ \$?) %f"


# autocomplete pass
if execable pass ; then
  pcg(){ pass generate -n -c $@ 16 && pass $@ ;  }
  pc(){  pass -c $@ && pass $@ ; }
  p(){ [[ $1 == "" ]] && echo "$(pass | tr -d '│├─└ ')" || pass $@; }
  compdef _pass pc
  compdef _pass p
fi
