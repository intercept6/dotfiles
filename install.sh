#!/usr/bin/env bash

set -eo pipefail

sudo sed --in-place -e '/auth.*required.*pam_shells.so/s/required/sufficient/g' /etc/pam.d/chsh

if type curl >/dev/null 2>&1; then
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
elif type wget >/dev/null 2>&1; then
	wget -nv -O - https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
	echo "Please install curl or wget before running this script."	
fi

zimfw install