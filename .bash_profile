#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# Add .NET Core SDK tools
export PATH="$PATH:/home/jbpratt/.dotnet/tools"
export GOROOT=/usr/local/go
export GOPATH=/home/jbpratt/go
export PATH=$PATH:$GOROOT/bin
