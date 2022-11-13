#!/bin/bash

RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'
    
colorEcho() {
    echo -e "${1}${@:2}${PLAIN}"
}

updateCommands() {
    NPM_CMD="$(command -v npm)"
    YARN_CMD="$(command -v yarn)"
    NVM_CMD="$(command -v nvm)"
    NODE_CMD="$(command -v node)"
}

echoCommands() {
    echo
    echo
    echo
    colorEcho $BLUE "########################################################################"
    #colorEcho $BLUE "nvm:" "$(nvm --version)"
    colorEcho $BLUE "node:" "$($NODE_CMD --version)"
    colorEcho $BLUE "npm:" "$($NPM_CMD --version)"
    colorEcho $BLUE "yarn:" "$($YARN_CMD --version)"
    colorEcho $BLUE "########################################################################"
    echo
    echo
    echo
}

installNvm() {
    if [[ -z "$NVM_CMD" ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

        colorEcho $GREEN "You didn't have node package manager, so i installed nvm!"
        updateCommands
    fi
}

installNpm() {
    if [[ -z "$NVM_CMD" ]]; then
        installNvm
    fi
    $NVM_CMD install --lts
    $NVM_CMD use --lts
    colorEcho $GREEN "You didn't have nodejs on your system, so i installed it for you!"
    updateCommands
}

installYarn() {
    $NPM_CMD install -g yarn
    colorEcho $GREEN "You didn't have yarn installed on your system, so i intalled it for you!"
    updateCommands
}

install() {
    if [[ -z "$NPM_CMD" ]]; then
        installNpm
        installYarn
    elif [[ -z "$YARN_CMD" ]]; then
        installYarn
    fi

    if [[ "$($NODE_CMD --version)" != "v18.12.1" ]]; then
        installNpm
        installYarn
    fi

    echoCommands
    colorEcho $GREEN "Your node package manager is up to date!"
}

updateCommands
install
