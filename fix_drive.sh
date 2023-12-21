#!/bin/bash

# Check if ntfsfix is installed
if ! command -v ntfsfix &> /dev/null
then
    echo "ntfsfix could not be found. Please install it and try again."
    exit
fi

# Prompt the user for the drive to use
echo "Please enter the drive you want to use (e.g., /dev/sda1):"
read user_drive

# Run ntfsfix with the user's drive
sudo ntfsfix -d $user_drive
