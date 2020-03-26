#
 #~/.bash_profile
#

export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export GOROOT=/usr/lib/go
export GOPATH=/home/jbpratt/go
export PATH=$PATH:$GOROOT/bin
export PATH="$PATH:$(go env GOROOT)/misc/wasm"
export PATH=$GOPATH/bin:$PATH
export PATH=~/bin:$PATH
export PATH=$HOME/.local/bin/:$PATH
export PATH=$HOME/.opam/default/bin/:$PATH
export PATH=$PATH:/home/jbpratt/Android/Sdk/platform-tools:/home/jbpratt/Android/Sdk/tools:/home/jbpratt/Android/Sdk/tools/bin
export PATH="$HOME/.node_modules/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export npm_config_prefix=~/.node_modules

# opam configuration
test -r /home/jbpratt/.opam/opam-init/init.sh && . /home/jbpratt/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
export TERMINFO=/usr/share/terminfo
