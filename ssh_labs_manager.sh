#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

DC="docker compose"

build_images() {
    echo -e "${GREEN}Building Docker images...${NC}"
    $DC build
}

start_containers() {
    echo -e "${GREEN}Starting Docker containers...${NC}"
    $DC up -d
    echo -e "${GREEN}Lab ready.${NC}"
    echo "Connect using:"
    echo "ssh -p 2222 hacker@localhost"
}

stop_remove_containers() {
    echo -e "${YELLOW}Stopping and removing containers...${NC}"
    $DC down
}

remove_images() {
    echo -e "${RED}Removing all images and volumes...${NC}"
    $DC down --rmi all --volumes --remove-orphans
}

show_menu() {
    while true; do
        echo "----- SSH LABS -----"
        echo "1) Build images"
        echo "2) Start containers"
        echo "3) Stop/Remove containers"
        echo "4) Remove images (FULL CLEAN)"
        echo "*) Exit"

        read -p "Select option: " choice

        case $choice in
            1) build_images ;;
            2) start_containers ;;
            3) stop_remove_containers ;;
            4) remove_images ;;
            *) echo -e "${RED}Exiting...${NC}" && exit 0 ;;
        esac
    done
}

show_menu
