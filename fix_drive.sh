#!/bin/bash

echo "ntfsfix requires sudo"
sleep 1
echo "please don't run the script unless you know what you're doing"
sleep .5
echo "----------------------------------------------"

if ! command -v ntfsfix &> /dev/null
then
    echo "ntfsfix could not be found. Please install it and try again."
    exit 1
fi

if [ "$EUID" -ne 0 ]
then
    echo "Please run this script with root privileges."
    exit 1
fi

echo "Please enter the drive you want to use (e.g., /dev/sda1):"
read user_drive

if [ ! -b "$user_drive" ]
then
    echo "Invalid drive. Please enter a valid drive."
    exit 1
fi

if [ ! -e "$user_drive" ]
then
    echo "Drive does not exist. Please enter a valid drive."
    exit 1
fi

echo "You are about to run ntfsfix on $user_drive. Are you sure? (y/n)"
read confirm

if [ "$confirm" != "y" ]
then
    echo "Operation cancelled."
    exit 0
fi

if ! sudo ntfsfix -d "$user_drive"
then
    echo "ntfsfix failed. Please check the drive and try again."
    exit 1
fi

echo "ntfsfix completed successfully."
exit 0
