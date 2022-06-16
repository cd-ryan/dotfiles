[[ $- = *i* ]] || return
autoload -U compinit

# zsh crap
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt appendhistory
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
fpath=(/usr/local/share/zsh-completions $fpath)
rm -f ~/.zcompdump; compinit

# aliases
alias ls="ls -G --color"

# functions
date2uday() {
    echo $(($(date --utc --date "$1" +%s)/86400))
}

# bindings
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# sourcing stuff
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# other vars
if which vis >/dev/null 2>&1; then
    export EDITOR=$(which vis)
elif which nvim >/dev/null 2>&1; then
    export EDITOR=$(which nvim)
elif which vim >/dev/null 2>&1; then
    export EDITOR=$(which vim)
fi

if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
    export PATH="$PATH:$GOPATH/bin"
fi
if [ -d "$HOME/bin" ]; then export PATH="$PATH:$HOME/bin" fi

# stop the damn blinking cursor in WSL
echo -e -n "\e[2 q"
