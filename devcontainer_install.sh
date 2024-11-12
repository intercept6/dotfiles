#!/usr/bin/env bash

set -e

echo "Starting local setup..."

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

stow --verbose --dir ~/dotfiles/packages --target ~ zsh
