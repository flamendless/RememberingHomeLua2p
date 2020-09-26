#!/bin/bash

dir_fonts=./fonts
dir_fonts_output=./output
dir_fonts_final=./final
dir_fonts_target=../res/fonts
fonts=(Jamboree DigitalDisco-Thin DigitalDisco Firefly Jamboree Luna Pixeled tiny uncle_type)
fonts_texture_size="1024,1024"

script_convert=./convertfont.py

function generate_fonts()
{
	mkdir -p "$dir_fonts"
	mkdir -p "$dir_fonts_output"
	mkdir -p "$dir_fonts_final"
	mkdir -p "$dir_fonts_target"
	for f in "${fonts[@]}"; do
		msdf-bmfont -o "$dir_fonts_output"/"$f".png -t msdf "$dir_fonts"/"$f".ttf -m "$fonts_texture_size"
	done
}

function convert_fonts()
{
	for f in "${fonts[@]}"; do
		python "$script_convert" "$dir_fonts_output"/"$f".fnt "$dir_fonts_final"/"$f".fnt;
	done
}

function copy_fonts()
{
	for f in "${fonts[@]}"; do
		cp "$dir_fonts_output"/"$f".png "$dir_fonts_target"
		cp "$dir_fonts"/"$f".ttf "$dir_fonts_target"
		cp -i "$dir_fonts_final"/"$f".fnt "$dir_fonts_target"
	done
}

if [ $# -eq 0 ]; then
	echo "Must pass command: generate_fonts, convert_fonts, copy_fonts"
else
	"$@"
fi
