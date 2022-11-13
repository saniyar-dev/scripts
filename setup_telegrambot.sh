#!/bin/bash
# Author: @saniyar_krmi
# Contact: @saniyar_dev (Telegram), saniayr.dev@gmail.com

RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'

colorEcho() {
    echo -e "${1}${@:2}${PLAIN}"
}

setupCommands() {
    GIT_CMD="$(command -v git)"
    YARN_CMD="$(command -v yarn)"
}

getProjectName() {
    Counter=0
    while [[ -z $PROJECT_NAME ]]; do
        if (( $Counter > 0 )); then
            colorEcho $RED "Don't leave this field empty!"
        fi
        read -p "Please enter your project name": PROJECT_NAME
        Counter=$(($Counter + 1))
    done
    Counter=0
}

setupNode() {
    chmod +x ./install_latest_node.sh
    ./install_latest_node.sh
}

installGit() {
    colorEcho $RED "Please install git first."

    updateCommands
}

getRepo() {
    if [[ -z "$GIT_CMD" ]]; then
        installGit
    fi

    git clone https://hamgit.ir/saniyar.dev/create-telegram-bot.git $PROJECT_NAME
    cd $PROJECT_NAME
}

installPackages() {
    $YARN_CMD install
}

setBotToken() {
    Counter=0
    while [[ -z $BOT_TOKEN ]]; do
        if (( $Counter > 0 )); then
            colorEcho $RED "Don't leave this field empty!"
        fi
        read -p "Please enter your bot token": BOT_TOKEN
        Counter=$(($Counter + 1))
    done

    echo "BOT_TOKEN=\"$BOT_TOKEN\"" > .env

    colorEcho $GREEN "BOT_TOKEN set successfully"
}

setupBot() {
    getProjectName
    getRepo
    setBotToken
    installPackages
}

setupNode
setupCommands
setupBot
