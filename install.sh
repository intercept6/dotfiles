#!/usr/bin/env bash

set -eo pipefail

if type curl >/dev/null 2>&1; then
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
elif type wget >/dev/null 2>&1; then
	wget -nv -O - https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
	echo "Please install curl or wget before running this script."	
fi

zimfw install