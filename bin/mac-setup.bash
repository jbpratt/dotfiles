#!/usr/bin/env bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

xcode-select --install
xcodebuild -license

brew update
brew upgrade

brew bundle --file=- <<RUBY
tap 'homebrew/cask'
tap 'homebrew/core'
tap 'homebrew/services'
RUBY

brew install git wget coreutils bash htop vim \
  shellcheck findutils tree lsd protobuf swift-protobuf

brew cask install firefox rectangle
brew cleanup
git clone https://github.com/jbpratt78/dotfiles.git "$HOME/"

echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash

ln -s "$HOME/dotfiles/.vim/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/dotfiles/.bash_aliases" "$HOME/.bash_aliases"
ln -s "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"

mkdir -p $HOME/.config/alacritty
ln -s "$HOME/dotfiles/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

/bin/cat <<EOM >~/.bashrc

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
EOM

if ! command -v osascript >/dev/null; then
	echo "$cmdname: osascript not found" >/dev/stderr
	exit
fi

# Kill System Preferences to prevent them from overriding settings
osascript -e 'tell application "System Preferences" to quit'

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Dock
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock largesize -int 54
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
osascript -e 'tell application "Dock" to quit'

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm -f /private/var/vm/sleepimage || :
# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage || :
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage || :

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

