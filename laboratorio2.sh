#!/bin/bash


#Ejercicio 3 recibir un ejecutable, correrlo y crear un archivo de log de consumo cpu y memoria, para graficarlo con gnuplot.
echo -n "Escriba el ejecutable que desea:" && read ejecutable
# Ejecuta el ejecutable binario
$ejecutable &
# Espera para que el proceso empiece
sleep 2
# Obtén el PID del proceso recién iniciado
identificador=$!
log="log_file.txt"
echo "Tiempo | CPU (%) | Memoria (KB)" > "$log"

while (ps -p "$identificador" > /dev/null); do
	tiempo=$(date "+%M:%S")
	CPU=$(ps -p "$identificador" -o %cpu)
	MEMORIA=$(ps -p "$identificador" -o %mem)
	echo ""$tiempo"  "$CPU"  "$MEMORIA"" >> "$log"
	sleep 3
done	

cat "log_file.txt"
