#!/usr/bin/env bash

set -eo pipefail

if type curl >/dev/null 2>&1; then
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

	# Download zimfw plugin manager if missing.
	if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
		curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
				https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
	fi

elif type wget >/dev/null 2>&1; then
	wget -nv -O - https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

	# Download zimfw plugin manager if missing.
	if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
		mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
				https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
	fi
else
	echo "Please install curl or wget before running this script."	
fi

zimfw install