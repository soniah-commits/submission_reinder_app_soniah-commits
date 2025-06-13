#!/bin/bash

# Ask the user to enter the name
echo "The directory has to have a name"
read -p "Please,Enter your directory name: " name

# Creating the folder

dir="submission_reminder_$name"
mkdir -p "$dir"
