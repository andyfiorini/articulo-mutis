#!/bin/bash
#
# Autor: Andres Garcia Fiorini
# Fecha: 27/06/2020
#


red/red.pl red/apeelidos.txt > redes.csv; grep "|" redes.csv  | grep -v "^|[0-9]" | sed 's/|//g' > red1.txt; sort -r -n -t: -k2 red1.txt  > red1-1.txt
grep ":" redes.csv  | grep -v "|:|" > red2.txt
grep -v ^: red2.txt > red3.txt
mv red3.txt red2.txt
