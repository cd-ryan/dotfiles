#!/usr/bin/env sh

if ! which go >/dev/null; then
    >&2 echo "install golang before continuing"
    exit 1
fi

SCRIPTDIR=$(dirname "$0")
SCRIPTDIR=$(readlink -f "$SCRIPTDIR")
cd "$SCRIPTDIR" || exit 1
git submodule update --init
cd - >/dev/null || exit 1

cd "$SCRIPTDIR"/entr || exit 1
./configure >/dev/null 2>&1
make
mkdir -p "$HOME"/bin
cp entr "$HOME"/bin
cd - >/dev/null || exit 1

export GOPATH="$HOME/go"
go get github.com/rogpeppe/godef
go get golang.org/x/tools/cmd/gorename

rsync -a "$SCRIPTDIR/.config/" "$HOME/.config" || exit 1
cp "$SCRIPTDIR"/.bashrc "$HOME"/. || exit 1
cp "$SCRIPTDIR"/.zshrc "$HOME"/. || exit 1
rsync -a "$SCRIPTDIR"/liquidprompt/ "$HOME"/liquidprompt

# must come after copying .bashrc and .zshrc
if [ ! -d "$HOME"/.fzf ]; then
    rsync -a "$SCRIPTDIR"/fzf/ ~/.fzf || exit 1
    sh -c 'yes | ~/.fzf/install' || exit 1
fi

