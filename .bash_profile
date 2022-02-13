#
#~/.bash_profile
#

export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export GOROOT=/usr/lib/go
export GO111MODULE=on
# export GOPROXY=http://localhost:3000,direct
export GOPATH="$HOME/go"
export CGO_CFLAGS="-g -O2 -Wno-return-local-addr"
export GOVIM_GOPLS_FLAGS="-remote=auto"
export GOPRIVATE=github.com/slugalisk/go-ppspp
export TERMINAL="alacritty"
export npm_config_prefix=$HOME/.node_modules
export TERMINFO=/usr/share/terminfo
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export DOCKER_BUILDKIT=1
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/21.3.6528147
export KUBECONFIG=$HOME/.kube/config$(find $HOME/.kube/configs -type f 2>/dev/null | xargs -I % echo -n ":%")
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$(go env GOROOT)/misc/wasm"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin/"
export PATH="$PATH:$npm_config_prefix/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
