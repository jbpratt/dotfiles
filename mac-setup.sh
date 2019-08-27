#!/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git wget
brew cask install iterm2
git clone https://github.com/jbpratt78/dotfiles.git $HOME/
cp $HOME/dotfiles/.vim/.vimrc $HOME/.vimrc
sh -c "$(wget https://dl.google.com/go/go1.12.9.darwin-amd64.pkg -0 -)"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
/bin/cat <<EOM >~/.gitconfig
[user]
  name = jbpratt 
  email = jbpratt78@gmail.com 
[core]
  editor = vim 
[alias]
  co = checkout
  lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit
  ci = commit
  cm = commit
  st = status
  amend = git commit --amend
  unstage = reset HEAD --
[url "git@github.com:"]
	insteadOf = https://github.com/
EOM

echo "set up ssh keys \
install slate wm, vscode \
modify zshrc, install powerline \
set up vscode extensions"
