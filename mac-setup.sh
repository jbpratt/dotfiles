#!/usr/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew install git wget coreutils \
	go python htop vim zsh rust pyenv \
	jq awscli itchyny/tap/gojo itchyny/tap/gojq \
	shellcheck findutils tree lsd m-cli
brew cask install iterm2 docker firefox slack visual-studio-code
brew cleanup
git clone https://github.com/jbpratt78/dotfiles.git "$HOME/"
cp "$HOME/dotfiles/.vim/.vimrc" "$HOME/.vimrc"

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

# https://github.com/itchyny/setup/blob/master/zsh-plugins
set -euxo pipefail

target=~/.zsh

if ! [ -e "$target" ]; then
	mkdir -p "$target"
fi

# http://mimosa-pudica.net/zsh-incremental.html
if ! [ -e "$target/incr-0.2.zsh" ]; then
	curl -L http://mimosa-pudica.net/src/incr-0.2.zsh |
		sed 's/^\(bindkey.*backward-delete-char-incr\)/# \1/' \
			>"$target/incr-0.2.zsh"
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

/bin/cat <<EOM >"$target/oh-my-zsh.sh"
plugins=(
  git
  osx
  docker
	zsh-auto-fillin
	zsh-git-alias
	zsh-syntax-highlighting
	zsh-history-substring-search
)
EOM

source $target/oh-my-zsh.sh

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo "ZSH_THEME=\"powerlevel9k/powerlevel9k\"" >>~/.zshrc

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

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

backgrounds=(
	IMG_1158.JPG
	IMG_1294.JPG
	IMG_1909.JPG
	IMG_2163.JPG
	IMG_2208.JPG
	IMG_2252.JPG
	IMG_2395.JPG
)

mkdir -p "$HOME/Pictures/backgrounds"
for b in "${backgrounds[@]}"; do
	curl -X GET "https://r7i6jef2h7.s3.us-east-2.amazonaws.com/$b"
done

m wallpaper "$HOME/Pictures/backgrounds/${backgrounds[1]}"
m dock position LEFT
