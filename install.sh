#!/usr/bin/env bash

set -e

if [ ! -f /opt/homebrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ ! -d ~/dotfiles ]; then
    cd ~
    git clone git@github.com:intercept6/dotfiles.git
fi

brew bundle --verbose --file=~/dotfiles/Brewfile

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

stow --verbose --dir ~/dotfiles/packages --target ~ zsh starship karabiner
