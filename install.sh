#!/usr/bin/env bash

set -eo pipefail

~/dotfiles/.bash_it/install.sh --silent

bash-it enable plugin \
	aws \
	docker \
	docker-compose \
	git \
	powerline 

bash-it enable completion \
	awscli \
	docker-compose \
	docker \
	gcloud \
	git \
	github-cli 
