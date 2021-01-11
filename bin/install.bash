#!/usr/bin/env bash

pushd "$HOME/dotfiles"

CONFIG="$HOME/dotfiles"

ln -s "$CONFIG/.bashrc" "$HOME/.bashrc"
ln -s "$CONFIG/.bash_profile" "$HOME/.bash_profile"
ln -s "$CONFIG/.bash_aliases" "$HOME/.bash_aliases"

mkdir -p $HOME/.config/{alacritty,i3}
ln -s "$CONFIG/i3/config" "$HOME/.config/i3/config"
ln -s "$CONFIG/i3/status.toml" "$HOME/.config/i3/status.toml"
ln -s "$CONFIG/i3/wsr.toml" "$HOME/.config/i3/wsr.toml"
ln -s "$CONFIG/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
ln -s "$CONFIG/starship.toml" "$HOME/.config/starship.toml"
