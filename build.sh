#!/bin/bash

os=$(uname)
lpp_path=./luapreprocess/preprocess-cl.lua
handler=handler_dev.lua

dir_modules=modules
dir_assets=assets
dir_output=output
dir_source=src

dir_sub=(assemblages components shaders systems worlds)
appdata=~/.local/share/love/goinghomerevisited

meta_exclude_modules=(spec docs example test love-sdf-text-testing rockspecs main.lua .travis .git examples .travis.yml)
exclude_modules=()
for e in "${meta_exclude_modules[@]}"; do
	exclude_modules+=("--exclude=$e")
done

meta_exclude_assets=(android audio gallery icons _images media new_assets soundtracks textures)
exclude_assets=()
for e in "${meta_exclude_assets[@]}"; do
	exclude_assets+=("--exclude=$e")
done

function create_output_dir()
{
	if [ ! -d "$dir_output" ]; then
		mkdir $dir_output
	fi
}

function process_src()
{
	for file in "$1"/*; do
		if [ -d "$file" ]; then
			local subd=$(echo "$file" | rev | cut -d'/' -f-1 | rev)
			if [ ! -d "$dir_output"/"$subd" ]; then
				mkdir "$dir_output"/"$subd"
			fi
			process_src "$file" "$subd"
		elif [ -f "$file" ]; then
			process_file "$file" "$2"
		fi
	done
}

function process_file()
{
	local filename="${1##*/}"
	local file=$(basename "$filename" .lua2p)
	local ext="${filename##*.}"
	local out=$dir_output/$2/$file

	if [ "$ext" == "lua2p" ]; then
		lua "$lpp_path" --handler="$handler" --outputpaths "$1" "$out".lua
	else
		cp "$1" "$out"
	fi
}

function copy_modules()
{
	rsync -av --progress "$dir_modules" "$dir_output" "${exclude_modules[@]}"
}

function copy_assets()
{
	rsync -av --progress "$dir_assets" "$dir_output" "${exclude_assets[@]}"
}

function clean()
{
	rm -rf $dir_output/*
}

function clean_logs()
{
	rm -i $appdata/*
}

function init()
{
	create_output_dir
	process_src "$dir_source"
	copy_modules
	copy_assets
}

function rebuild()
{
	clean
	create_output_dir
	process_src "$dir_source"
	copy_modules
	copy_assets
}

function run()
{
	if [ ! -d "$dir_output" ]; then
		echo "No output dir detected; Run init first"
	else
		process_src "$dir_source"
		love "$dir_output"
	fi
}

if [ $# -eq 0 ]; then
	echo "Must pass command: init, rebuild, clean, run"
else
	"$@"
fi
