#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# Add .NET Core SDK tools
export PATH="$PATH:/home/jbpratt/.dotnet/tools"
export PATH=$PATH:$GOROOT/bin
export PATH="$PATH:$(go env GOROOT)/misc/wasm"
export PATH=$GOPATH/bin:$PATH
export PATH=~/bin:$PATH
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export GOROOT=/usr/lib/go
export GOPATH=/home/jbpratt/go
