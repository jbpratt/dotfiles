#
#~/.bash_profile
#

export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export GOROOT=/usr/lib/go
export GO111MODULE=on
export GOPROXY=http://localhost:3000,direct
export GOPATH="$HOME/go"
export TERMINAL="alacritty"
export npm_config_prefix=$HOME/.node_modules
export TERMINFO=/usr/share/terminfo
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export DOCKER_BUILDKIT=1
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$(go env GOROOT)/misc/wasm"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$npm_config_prefix/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
