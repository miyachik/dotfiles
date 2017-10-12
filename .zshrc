
plugins=(git)

# User configuration
export PATH="/usr/local/bin:/Users/miyachi/.rbenv/shims:/Users/miyachi/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/kenta.miyachi/.nodebrew/current/bin:/usr/local/go/bin"
# export PATH="/usr/local/bin:/Users/kenta.miyachi/.nodebrew/current/bin:/Users/kenta.miyachi/.rbenv/shims:/Users/kenta.miyachi/.rbenv/bin"

# for GO
export GOPATH='/Users/kenta.miyachi'
export GOROOT='/usr/local/go'
export PATH=$PATH:$GOPATH/bin

# 補完
# for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# syntax-highlight
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# 補完機能を有効にする

autoload -Uz compinit
compinit -u
setopt correct

#右側に現在のブランチを表示
#未コミット時は赤、アップデートがないときは黄色
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi

        name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  if [[ -e "$gitdir/rprompt-nostatus" ]]; then
    echo "$name$action "
    return
  fi

        st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=%B%F{red}
        else
                color=%F{red}
        fi

        echo "$color$name$action%f%b "
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

RPROMPT='[`rprompt-git-current-branch`%~]'

# LScolor
export LSCOLORS=Exfxcxdxbxegedabagacad

# 左プロンプトにはユーザー名のみ表示
PROMPT="[%n]%{[34m%}%(#.#.%%)%{[m%} "
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

eval "$(direnv hook zsh)"
export EDITOR=emacs

function openpr() {
  local current_branch_name=$(git symbolic-ref --short HEAD | xargs perl -MURI::Escape -e 'print uri_escape($ARGV[0]);')
  hub browse -- pull/${current_branch_name}
}

# for peco
peco-select-history() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# プロセスの停止
function peco-pkill() {
for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"

# for anyframe
fpath=($HOME/.zsh/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init

bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch

bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

#for gvm
[[ -s "/Users/kenta.miyachi/.gvm/scripts/gvm" ]] && source "/Users/kenta.miyachi/.gvm/scripts/gvm"
