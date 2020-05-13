#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

if [ -f ~/.private ]; then
	source ~/.private
fi

if [ -f ~/.bash_profile ]; then
	source ~/.bash_profile
fi

export GO111MODULE=on
export GOPROXY=http://localhost:3000,direct
export PS1="\W >\[$(tput sgr0)\]"
export PATH="$PATH:$HOME/.cargo/bin"

xhost +local:root >/dev/null 2>&1

complete -cf sudo

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
complete -C aws_completer aws
source <(golangci-lint completion bash)
eval "$(gh completion)"

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

HISTSIZE=
HISTFILESIZE=

# https://github.com/junegunn/fzf/wiki/examples
fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m) &&
		cd "$dir"
}

fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
		branch=$(echo "$branches" |
			fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

da() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

ds() {
	local cid
	cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker stop "$cid"
}

drm() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker rm "$cid"
}

source $HOME/gitstatus/gitstatus.plugin.sh

function my_set_prompt() {
	PS1='\w'

	if gitstatus_query && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
		if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
			PS1+=" ${VCS_STATUS_LOCAL_BRANCH//\\/\\\\}" # escape backslash
		else
			PS1+=" @${VCS_STATUS_COMMIT//\\/\\\\}" # escape backslash
		fi
		[[ "$VCS_STATUS_HAS_STAGED" == 1 ]] && PS1+='+'
		[[ "$VCS_STATUS_HAS_UNSTAGED" == 1 ]] && PS1+='!'
		[[ "$VCS_STATUS_HAS_UNTRACKED" == 1 ]] && PS1+='?'
	fi

	PS1+=' '
	shopt -u promptvars # disable expansion of '$(...)' and the like
}

gitstatus_stop && gitstatus_start
PROMPT_COMMAND=my_set_prompt
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
function kotlinr() {
	echo Compiling, please wait...
	kotlinc $1 -include-runtime -d out.jar
	java -jar out.jar
}

eval "$(zoxide init bash)"

if [[ -x "$(command -v fw)" ]]; then
	if [[ -x "$(command -v fzf)" ]]; then
		eval "$(fw print-bash-setup -f 2>/dev/null)"
	else
		eval "$(fw print-bash-setup 2>/dev/null)"
	fi
fi
export DOCKER_BUILDKIT=1
