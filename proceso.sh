#!/bin/bash -x
#
# Autor: Andres Garcia Fiorini
# Fecha: 13/06/2020
#

CUENTA=1;
for LIBRO in `ls *.pdf`;
do

	LIBRO_TXT=`echo $LIBRO | sed 's/pdf/txt/'| sed 's/PDF/txt/g'`;
	./parsear_cartas.pl $LIBRO $LIBRO_TXT 31 $CUENTA
	sleep 5;
	if [ ! -d $CUENTA ];
	then
		mkdir $CUENTA;
	fi
	cd $CUENTA;
	if [ $? != 0 ];
	then
	   echo "$CUENTA: directorio no existe;"
	   exit;
	fi
	for txt in `ls *.txt`;
	do
	  cmd /C "..\tokens.py $txt";
	done
	cd ..;
	let CUENTA=$((CUENTA))+1;

done
