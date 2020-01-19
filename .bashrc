#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi


if [ -f ~/.bash_profile ]; then
	source ~/.bash_profile
fi

export GO111MODULE=on
export PS1="\W >\[$(tput sgr0)\]"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/flutter/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT=$ANDROID_HOME

xhost +local:root >/dev/null 2>&1

complete -cf sudo

shopt -s checkwinsize

shopt -s expand_aliases

shopt -s histappend

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

#
# # ex - archive extractor
# # usage: ex <file>
ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}


complete -C aws_completer aws
