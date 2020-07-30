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
export PATH="$HOME/python3.9/bin:$PATH"
export PATH="$npm_config_prefix/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
  --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
  --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
  --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
