#Laboratorio 2 del curso de plataformas acerca de procesos y servicios utilizando el branch de git. 
#!/bin/bash

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

#Ejercicio 3 recibir un ejecutable, correrlo y crear un archivo de log de consumo cpu y memoria, para graficarlo con gnuplot.



