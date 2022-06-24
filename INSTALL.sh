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
go install github.com/rogpeppe/godef@latest
go install golang.org/x/tools/cmd/gorename@latest

rsync -a "$SCRIPTDIR/.config/" "$HOME/.config" || exit 1
cp "$SCRIPTDIR"/.bashrc "$HOME"/. || exit 1
cp "$SCRIPTDIR"/.zshrc "$HOME"/. || exit 1
rsync -a "$SCRIPTDIR"/liquidprompt/ "$HOME"/liquidprompt

# must come after copying .bashrc and .zshrc
if [ ! -d "$HOME"/.fzf ]; then
    rsync -a "$SCRIPTDIR"/fzf/ ~/.fzf || exit 1
    sh -c 'yes | ~/.fzf/install' || exit 1
fi

if which cc >/dev/null 2>&1 && [ ! -f "$HOME"/bin/nq ]; then
    cd "$SCRIPTDIR"/nq || exit 1
    make check && make && cp nq fq "$HOME"/bin/.
    cd - || exit 1
fi
cp "$SCRIPTDIR"/nq/nq.sh "$SCRIPTDIR"/nq/fq.sh "$HOME"/bin/.

