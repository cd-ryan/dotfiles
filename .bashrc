[[ $- = *i* ]] || return

# bash history
HISTFILE="$HOME/.bash_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTCONTROL="ignoredups"

# aliases
if ! ls -G >/dev/null 2>&1; then
    alias ls="ls --color"
else
    alias ls="ls -G --color"
fi

# functions
date2uday() {
    echo $(($(date --utc --date "$1" +%s)/86400))
}

# vars before sourcing
export LP_ENABLE_COLOR=0
export LS_COLORS=""

# sourcing stuff
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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
if [ -d "$HOME/bin" ]; then export PATH="$PATH:$HOME/bin"; fi

# stop the damn blinking cursor in WSL
echo -e -n "\e[2 q"
