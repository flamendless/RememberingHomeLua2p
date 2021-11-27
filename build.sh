#!/bin/bash

lua=luajit
os=$(uname)
lpp_path=./libs/LPP/preprocess-cl.lua
gv=$(git log -1 --format='v%cd.%h' --date=short 2>/dev/null)
data=dev
handler=handler.lua

dir_modules=modules
dir_res=res
dir_output=output_dev
dir_source=src

dir_sub=(assemblages components shaders states systems)
appdata=~/.local/share/love/goinghomerevisited

meta_exclude_modules=(
	spec docs example test love-sdf-text-testing rockspecs main.lua .travis
	.git examples .travis.yml changelog.txt README.md MakeSingle.mak bench
	CHANGELOG.md *.rockspec config.ld performance_test.lua USAGE.md img
)
exclude_modules=()
for e in "${meta_exclude_modules[@]}"; do
	exclude_modules+=("--exclude=$e")
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
		$lua "$lpp_path" --handler="$handler" --data="$data $gv" --outputpaths "$1" "$out".lua --silent;
		if [ $? -ne 0 ]; then
			exit;
		fi
	else
		cp "$1" "$out"
	fi
}

function check()
{
	# https://luacheck.readthedocs.io/en/stable/cli.html
	local file="$dir_output"
	if [ $# -eq 2 ]; then
		if [[ $2 == src* ]]; then
			file="${file}/${2:4}"
		else
			file="${file}/$2"
		fi
	fi
	luacheck $file -q \
		--exclude-files "output_dev/modules/**/*.lua" \
		--std luajit \
		--globals love stringx mathx tablex pretty intersect timer \
		--no-max-line-length \
		--ignore 611 \
		--jobs 2
}

function create_atlas()
{
	exported_path=./res/exported
	exported_dirs=(intro kitchen living_room outside storage_room utility_room)
	out_dir=./res/images/atlases/
	eta_path=./libs/ExportTextureAtlas/

	for in_dir in "${exported_dirs[@]}"; do
		love $eta_path \
			$exported_path/$in_dir \
			$out_dir/$in_dir \
			-removeFileExtension \
			-throwUnsupportedImageExtension \
			-padding 4 \
			-template "./scripts/atlas_template.lua"
	done
}

function copy_modules()
{
	rsync -av --progress "$dir_modules" "$dir_output" "${exclude_modules[@]}"
}

function copy_res()
{
	rsync -av --progress "$dir_res" "$dir_output"
}

function clean()
{
	rm -rfv $dir_output/*
}

function clean_logs()
{
	rm -v $appdata/*
}

function init()
{
	create_output_dir
	process_src "$dir_source"
	copy_modules
	copy_res
}

function rebuild()
{
	clean
	create_output_dir
	copy_modules
	copy_res
	cp slab.style $dir_output
}

function run()
{
	echo "Running build.sh"
	process_src "$dir_source"
	love "$dir_output"
	echo "Completed build.sh"
}

function profile()
{
	data=prof
	dir_output=output_dev
	run
	prof_viewer
}

function prof_viewer()
{
	love modules/jprof goinghomerevisited prof.mpack
}

if [ $# -eq 0 ]; then
	echo "Must pass command: init, rebuild, clean, run, create_atlas"
else
	"$@"
fi
