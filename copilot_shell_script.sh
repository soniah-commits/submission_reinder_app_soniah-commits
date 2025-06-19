#!/bin/bash
read -p "Enter the same name as entered in the directory name: " recentName

if [ -z "$recentName" ]; then
	echo "Enter your recent directory name."
	exit 1
fi
if ! [[ "$recentName" =~ ^[a-zA-Z\s]+$ ]]; then
    echo "The Assignment name must contain."
    echo "only letters and spaces."
    exit 1
fi

dir="submission_reminder_$recentName"
submissions="$dir/assets/submissions.txt"
read -p "Enter the assignment to check: " task
read -p "Enter the number of days remaining: " days
