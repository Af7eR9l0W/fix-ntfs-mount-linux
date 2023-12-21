#!/bin/bash

RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}ntfsfix${NC} requires sudo"
sleep 1
echo "please don't run the script unless you know what you're doing"
sleep .5
echo "----------------------------------------------"

if ! command -v ntfsfix &> /dev/null
then
    echo -e "${CYAN}ntfsfix${NC} ${RED}could not be found.${NC} ${RED}Please install it and try again.${NC}"
    exit 1
fi

if [ "$EUID" -ne 0 ]
then
    echo -e "${RED}Please run this script with root privileges.${NC}"
    exit 1
fi

echo -e "${CYAN}Please enter the drive you want to use${NC} ${GREEN}(e.g., /dev/sda1):${NC}"
read user_drive

if [ ! -b "$user_drive" ]
then
    echo -e "${RED}Invalid drive.${NC} ${GREEN}Please enter a valid drive.${NC}"
    exit 1
fi

if [ ! -e "$user_drive" ]
then
    echo -e "${RED}Drive does not exist.${NC} ${GREEN}Please enter a valid drive.${NC}"
    exit 1
fi

echo -e "${GREEN}You are about to run${NC} ${CYAN}ntfsfix${NC} ${GREEN}on $user_drive. ${CYAN}Are you sure?${NC} ${RED}(y/n)${NC}"
read confirm

if [ "$confirm" != "y" ]
then
    echo -e "${RED}Operation cancelled."
    exit 0
fi

if ! sudo ntfsfix -d "$user_drive"
then
    echo -e "${RED}ntfsfix failed. Please check the drive and try again.${NC}"
    exit 1
fi

echo -e "${CYAN}ntfsfix ${GREEN}completed successfully."
exit 0
