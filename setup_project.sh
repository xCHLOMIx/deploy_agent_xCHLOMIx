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

setup_directory
