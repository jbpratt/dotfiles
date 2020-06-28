#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases
[[ -f $HOME/.private ]] && source $HOME/.private
[[ -f $HOME/.bash_profile ]] && source $HOME/.bash_profile

export PS1="\W >\[$(tput sgr0)\]"
export HISTSIZE=
export HISTFILESIZE=

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
eval "$(zoxide init bash)"
eval "$(aactivator init)"

if [[ -x "$(command -v fw)" ]]; then
	if [[ -x "$(command -v fzf)" ]]; then
		eval "$(fw print-bash-setup -f 2>/dev/null)"
	else
		eval "$(fw print-bash-setup 2>/dev/null)"
	fi
fi

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
