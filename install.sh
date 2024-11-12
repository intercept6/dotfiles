#!/usr/bin/env bash

set -e

if [ "$REMOTE_CONTAINERS" = "true" ]; then
    ./devcontainer_install.sh
else
    ./local_install.sh
fi
