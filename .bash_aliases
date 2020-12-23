alias cp="cp -i"     # confirm before overwriting something
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias more=less
alias ls="lsd"
alias ll="ls -lahF"
alias lt='ls --tree'
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias grep='grep --color=auto'
alias weather="curl wttr.in/Birmingham,AL?format=v2"
alias gc="git commit -vp"
alias ga="git number add"
alias gd="git diff --cached"
alias gs="git number"
alias jq="gojq"
alias gofmt="gofumpt"
alias goimports="gofumports"
alias gmodu="go list -u -m -json all | go-mod-outdated -direct -update"
alias cat="bat"
alias notes="vim $HOME/notes.md"
alias ssh="TERM=xterm-256color ssh -v"
alias mutt="neomutt"
alias get_idf='. $HOME/esp/esp-idf/export.sh'
