
echo "Keep prepared ligand file in the same directory and remove or move other compound to other directory"
read -p "Enter Receptor: " rec
read -p "center_x :" cx
read -p "center_y :" cy
read -p "center_z :" cz

read -p "size_x :" sx
read -p "size_y :" sy
read -p "size_z :" sz





for dock in *.pdbqt; do
	base="${dock%.pdbqt}"
	cat <<EOF > $base.config
receptor=$rec.pdbqt
ligand=$dock
center_x=$cx
center_y=$cy
center_z=$cz
size_x=$sx
size_y=$sy
size_z=$sz

out=${base}_result.pdbqt
exhaustiveness=100
log=$base.log
EOF

	./vina.exe --config $base.config
	mkdir ./$base
	cp $rec.pdbqt ./$base
	./vina_split.exe --input ${base}_result.pdbqt
done
