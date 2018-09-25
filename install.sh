#!/bin/bash

# Sets up new system with installations:
# - brew
# - pip
# - GNU tools
# - tmux
# - updated bash
# - git
# - cmake

# Dependency:
# Command Line Tools

# should run once, but if run multiple times
# should be idempotent. Idempotency relies
# on brew, pip and code, so it may update 
# certain packages in the process.

read -r -n 1 -p "Proceed with installation? [y|N] " response

if [[ "$response" =~ (n|N) || -z "$response" ]];
then
    exit 1
fi

DOTFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BREWFILE_DIR="$DOTFILE_DIR/brew"
PIP_BIN=$(brew --prefix)'/bin/pip'
VSCODE_DIR="$DOTFILE_DIR/vscode"

install_brew() {
    # Install Homebrew
    if ! [[ -x "$(command -v brew)" ]]; then 
        printf "Homebrew not found on this system; Installing...\\n"
        # installs command line tools
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_brew_packages() {
    if [[ -x "$(command -v brew)" ]]; then 
        (cd "$BREWFILE_DIR" && exec brew bundle)
    fi
}

install_pip_packages() {
    if [[ -x "$(command -v $PIP_BIN)" ]]; then
        $PIP_BIN install virtualenv pylint
    fi
}

configure_vs_code() {
    (cd "$VSCODE_DIR" && exec ./configure.sh)
}

## execute main if called as a script
## (e.g. not with `source`)
if [[ "$BASH_SOURCE" == $0 ]]; then
    install_brew
    brew update
    brew upgrade
    brew cleanup

    install_brew_packages
    install_pip_packages
    configure_vs_code
fi