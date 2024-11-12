#!/usr/bin/env bash

set -e

if [ ! -f /opt/homebrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ ! -f ~/dotfiles ]; then
    cd ~
    git clone git@github.com:intercept6/dotfiles.git
fi

brew bundle -v --file=~/dotfiles/Brewfile
