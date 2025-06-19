#!/bin/bash
read -p "Enter the same name as entered in the directory name: " recentName

if [ -z "$recentName" ]; then
	echo "Enter your recent directory name."
	exit 1
fi
if ! [[ "$recentName" =~ ^[a-zA-Z\s]+$ ]]; then
    echo "The Entered name must not contain numbers."
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
    echo "The Days have to be numbers."
    exit 1
fi

if ! echo "$task" | grep -qE '^[A-Za-z ]+$'; then
    echo "The Assignment name must not contain numbers."
    exit 1
fi

matchingAssignment=$(grep -i ", *$task," "$submissions" | awk -F',' '{print $2}' | head -n1 | xargs)

if [ -z "$matchingAssignment" ]; then
    echo "Assignment '$task' isn't found in submissions.txt"
    echo "Try again."
    exit 1
fi

echo "Updating config.env in $dir/config/"
echo "ASSIGNMENT=\"$matchingAssignment\"" > "$dir/config/config.env"
echo "DAYS_REMAINING=$days" >> "$dir/config/config.env"

echo "Configuration updated:"
cat "$dir/config/config.env"

read -p "Open the reminder app now? (y/n): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Launching the app..."
    bash "$dir/startup.sh"
    echo "The app has started"
else
    echo "Reminder app did not start."
    echo "Run it later using: bash $dir/startup.sh"
fi
