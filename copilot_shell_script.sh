#!/bin/bash
read -p "Enter the same name as entered in the directory name: " recentName
dir="submission_reminder_$recentName"
submissions="$dir/assets/submissions.txt"
read -p "Enter the assignment to check: " task
read -p "Enter the number of days remaining: " days
