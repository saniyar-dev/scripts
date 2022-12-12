#!/bin/bash
# Author: @saniyar_krmi

RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'

colorEcho() {
    echo -e "${1}${@:2}${PLAIN}"
}

checkSystem() {
    rootResault=$(id | awk '{print $1}')
    if [[ $rootResault != "uid=0(root)" ]]; then
        colorEcho $RED "You should run this script as root."
        exit 1
    fi
}

commandLineSetup() {
    apt update
    apt install zsh
    
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

checkSystem()
commandLineSetup()
