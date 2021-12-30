#!/bin/bash

dir_source=src
dir_output=output_dev
file_makelove=makelove.toml
cmd="/mnt/c/Windows/System32/cmd.exe"
path_love="C:\Program Files\LOVE"
path_game="A:\home\flamendless\GoingHomeRevisited\release\love\GoingHomeRevisited.love"

function win32()
{
	cd "$dir_output" && makelove --config ../"$file_makelove" win32
}

function win64()
{
	cd "$dir_output" && makelove --config ../"$file_makelove" win64
}

function run()
{
	echo "Running build_win.sh"
	./build.sh process_src "$dir_source"
	win64
	$cmd /c "cd $path_love & lovec.exe $path_game"
	echo "Completed build_win.sh"
}

if [ $# -eq 0 ]; then
	echo "Must pass command: win32, win64, run"
else
	"$@"
fi
