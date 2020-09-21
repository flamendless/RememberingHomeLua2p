#!/bin/bash

dir_output=output
file_makelove=makelove.toml

function win32()
{
	cd "$dir_output"
	makelove --config ../"$file_makelove" win32
}

function win64()
{
	cd "$dir_output"
	makelove --config ../"$file_makelove" win64
}

if [ $# -eq 0 ]; then
	echo "Must pass command: win32 or win64"
else
	"$@"
fi
