#!/bin/bash

echo "Split: 1"
echo "Convert: 2"
echo "Minimize: 3"
echo "Convert 2D to 3D: 4"
read -p "Enter your value: " value
#obabel -i sdf 2D_146157204.sdf -o pdbqt 146157204.pdbqt -h --gen3d
case $value in
	1)
	  read -p "Input filename (with extension): " input_file
	  obabel $input_file -O $input_file -m
	;;

	2)
	  read -p "Input format: " input_ext
	  read -p "output format: " output_ext

	  for file in *.$input_ext; do
    		base="${file%.$input_ext}"
    		echo "Converting $file → $base.$output_ext"
    		obabel "$file" -O "$base.$output_ext"
	  done

	  echo "Done!"
	;;

	3)
	  read -p "Input format: " input_ext
	  for file in *.$input_ext; do
		base="${file%.$input_ext}"
		echo "Minimizing $file using UFF ff → $file"
		obminimize -ff UFF -n 500 "$file" > "${base}_min.$input_ext"
	  done

	  echo "All minimizations complete."
	;;

	4)
	  for file in 2D_*.sdf; do
		rm_ext="${file%.sdf}"
		base="${rm_ext#*_}"
		obabel -i sdf $file -o pdbqt $base.pdbqt -h --gen3d
	  echo $base
	  done
	;;
esac
