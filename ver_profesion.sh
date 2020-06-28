#!/bin/bash -n
#
# Autor: Andres Garcia Fiorini
# Fecha: 13/06/2020
#

for i in `cat red1.txt | awk -F: '{print $1}'`;
#for i in `awk -v  RS="\n" '{ print; }' < red1.txt`;
do
    printf "$i:";
    grep "$i " red_de2.csv | awk -F";" '{print $2}';
done
