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

if [ ! -d "$dir" ]; then
	echo "Directory '$dir' not found, run create_environment.sh."
	exit 1
fi

read -p "Enter the assignment to check: " task
read -p "Enter the number of days remaining: " days
task=$(echo "$task" | sed "s/$(echo -e '\u00a0')/ /g" | tr -cd '[:alnum:] [:space:]' | xargs)

days=$(echo "$days" | xargs)

echo "DEBUG: [$task]"

if [ -z "$task" ] || ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "The Assignment name cannot be empty"
    echo "and"
    echo "The Days have to be numbers."
    exit 1
fi
