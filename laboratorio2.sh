#!/bin/bash
#Laboratorio 2 del curso de plataformas acerca de procesos y servicios utilizando el branch de git. 

#Ejercicio 1, el script recibe el ID de un proceso y devuelve información del mismo.
echo -n "Escriba el número de ID del proceso:" && read ID 
#Encontrar el nombre del proceso
nombre=$(ps -p "$ID" -o comm=)
echo "El nombre del proceso es: $nombre"
#El ID del proceso
echo "El numero del proceso es: $ID"
#El parent process ID
ppid=$(ps -p "$ID" -o ppid=)
echo "El ppid es: $ppid"
#Propietario
user=$(ps -p "$ID" -o user=)
echo "El usuario propietario es: $user"
#Porcentaje de CPU
cpu=$(ps -p "$ID" -o %cpu)
echo "El porcentaje de cpu usado es: $cpu"
#Consumo de memoria
memoria=$(ps -p "$ID" -o %mem)
echo "El consumo de memoria es de: $memoria"
#Estado del proceso 
stat=$(ps -p "$ID" -o stat)
echo "El estado del proceso es: $stat"
#El path del ejecutable
path=$(readlink /proc/$ID/exe)
echo "La ruta del ejecutable del proceso es: $path"

#Ejercicio 2, si el proceso se cierra, volver a levantarlo.
echo -n "Escriba el nombre del proceso:" && read process_name
echo -n "Escriba el comando a ejecutar con el proceso:" && read process_command

while true; do
	if pgrep -x "$process_name" > /dev/null; then
		echo "Es proceso SÍ está corriendo"
	else 
		echo "El proceso $process_name se cayó.Se va a volver a levantar el programa."
		eval "$process_command"
	fi
	sleep 10
done

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

