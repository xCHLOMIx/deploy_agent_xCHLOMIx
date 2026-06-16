#!/usr/bin/env bash

function setup_directory() {
	echo "Setting up directory structure..."
	mkdir "./$1" "./$1/Helpers" "./$1/reports"
	echo "Directory structure successfully setup!"
	echo "Adding initial files..."
	cp files/attendance_checker.py "./$1"
	cp files/assets.csv "./$1/Helpers"
	cp files/config.json "./$1/Helpers"
	cp files/reports.log "./$1/reports"
	echo "Initial files successfully added!"
}

function edit_config() {
	# Collect values from the user

	while true
	do
		read -p "Enter new warning value 0 - 100 (Default 75): " new_warning_value
		read -p "Enter new failure value 0 - 100 (Default 50): " new_failure_value
		
		if [[ $new_warning_value =~ ^[0-9]+$ && $new_failure_value =~ ^[0-9]+$ ]]
		then
			# Make in-place edits in temp.json file and replace the config.json file
			sed "3 s/75/$new_warning_value/" "./$1/Helpers/config.json" > "./$1/Helpers/temp.json" && mv "./$1/Helpers/temp.json" "./$1/Helpers/config.json"
			sed "4 s/50/$new_failure_value/" "./$1/Helpers/config.json" > "./$1/Helpers/temp.json" && mv "./$1/Helpers/temp.json" "./$1/Helpers/config.json"
			echo "Successfully set the warning value to '$new_warning_value' and the failure value to '$new_failure_value'"
			break
		else
			echo "New values must be numbers"
		fi
	done
}

function handle_interruption() {
	echo "Nice"
	exit
}

function setup() {
	trap handle_interruption INT

	while true; do
		read -p "Enter tracker version (e.g: v1): " version
		directory_name="attendance_tracker_$version"

		if [ -d "$directory_name" ]
		then
			echo "Try a different version. $directory_name already exists"
		else
			setup_directory $directory_name
			break
		fi
	done
	
	while true; do
		read -p "Do you want to setup your own warning and failure values? [y/n]: " choice

		if [ "$choice" == "y" ]
		then
			edit_config $directory_name
			break
		elif [ "$choice" == "n" ]
		then
			echo "Successfully setup the project!"
			break
		else
			echo "Invalid choice choose bettween [y/n]"
		fi
	done
}

setup
