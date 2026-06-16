#!/usr/bin/env bash

read -p "Enter tracker version (e.g: v1): " version

directory_name="attendance_tracker_$version"

function setup_directory() {
	echo "Setting up directory structure..."
	mkdir "./$directory_name" "./$directory_name/Helpers" "./$directory_name/reports"
	echo "Directory structure successfully setup!"
	echo "Adding initial files..."
	cp files/attendance_checker.py "./$directory_name"
	cp files/assets.csv "./$directory_name/Helpers"
	cp files/config.json "./$directory_name/Helpers"
	cp files/reports.log "./$directory_name/reports"
	echo "Initial files successfully added!"
}

function edit_config() {
	read -p "Enter new warning value 0 - 100 (Default 75): " new_warning_value
	read -p "Enter new failure value 0 - 100 (Default 50): " new_failure_value
	sed "3 s/75/$new_warning_value/" "./$directory_name/Helpers/config.json" > "./$directory_name/Helpers/temp.json" && mv "./$directory_name/Helpers/temp.json" "./$directory_name/Helpers/config.json"
	sed "4 s/50/$new_failure_value/" "./$directory_name/Helpers/config.json" > "./$directory_name/Helpers/temp.json" && mv "./$directory_name/Helpers/temp.json" "./$directory_name/Helpers/config.json"
	echo "Successfully set the warning value to '$new_warning_value' and the failure value to '$new_failure_value'"
}

function setup() {
	setup_directory
	read -p "Do you want to setup your own warning and failure values? [y/n]: " choice

	if [ "$choice" == "y" ]
	then
		edit_config
	else
		echo "Successfully setup the project"
	fi
}

setup
