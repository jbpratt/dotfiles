#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[[ -r /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases
[[ -f $HOME/.private ]] && source $HOME/.private
[[ -f $HOME/.bash_profile ]] && source $HOME/.bash_profile

export PS1="\W >\[$(tput sgr0)\]"
export HISTSIZE=
export HISTFILESIZE=
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

complete -cf sudo

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

[[ -x "$(command -v gh)" ]] && eval "$(gh completion)"
[[ -x "$(command -v starship)" ]] && eval "$(starship init bash)"
[[ -x "$(command -v aactivator)" ]] && eval "$(aactivator init)"
[[ -x "$(command -v zoxide)" ]] && eval "$(zoxide init bash)"
[[ -x "$(command -v pipx)" ]] && eval "$(register-python-argcomplete pipx)"
[[ -x "$(command -v oc)" ]] && source <(oc completion bash)
[[ -x "$(command -v kubectl)" ]] && source <(kubectl completion bash)
[[ -x "$(command -v tkn)" ]] && source <(tkn completion bash)
[[ -x "$(command -v podman)" ]] && source <(podman completion bash)

#
# # ex - archive extractor
# # usage: ex <file>
ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.tar.xz) tar xf $1 ;;
		*.xz) unxz $1 ;;
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
