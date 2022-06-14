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

if [ -f "$HOME/.bashrc" ]; then
    grep "^export GOPATH" "$HOME/.bashrc" >/dev/null || echo 'export GOPATH="$HOME/go"' >> "$HOME/.bashrc"
    grep "^export PATH" "$HOME/.bashrc" | grep "GOPATH" >/dev/null || echo 'export PATH="$PATH:$GOPATH/bin"' >> "$HOME/.bashrc"
    grep "^export PATH" "$HOME/.bashrc" | grep "HOME/bin" >/dev/null || echo 'export PATH="$PATH:$HOME/bin"' >> "$HOME/.bashrc"
fi
if [ -f "$HOME/.zshrc" ]; then
    grep "^export GOPATH" "$HOME/.zshrc" >/dev/null || echo 'export GOPATH="$HOME/go"' >> "$HOME/.zshrc"
    grep "^export PATH" "$HOME/.zshrc" | grep "GOPATH" >/dev/null || echo 'export PATH="$PATH:$GOPATH/bin"' >> "$HOME/.zshrc"
    grep "^export PATH" "$HOME/.zshrc" | grep "HOME/bin" >/dev/null || echo 'export PATH="$PATH:$HOME/bin"' >> "$HOME/.zshrc"
fi

go get github.com/rogpeppe/godef
go get golang.org/x/tools/cmd/gorename
rsync -a "$SCRIPTDIR/.config/vis/" "$HOME/.config/vis"

