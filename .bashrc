[[ $- = *i* ]] || return

# bash history
HISTFILE="$HOME/.bash_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTCONTROL="ignoredups"

# aliases
alias ls="ls -G --color"

# functions
date2uday() {
    echo $(($(date --utc --date "$1" +%s)/86400))
}

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
if [ -d "$HOME/bin" ]; then export PATH="$PATH:$HOME/bin" fi

# stop the damn blinking cursor in WSL
echo -e -n "\e[2 q"
