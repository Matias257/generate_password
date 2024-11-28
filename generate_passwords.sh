#!/bin/bash

echo -e "\e[1;32m
╭━━━╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮
┃╭━╮┃╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃
┃┃╱╰╋━━┳━╮╭━━┳━┳━━┳━╯┣━━┳━╮
┃┃╭━┫┃━┫╭╮┫┃━┫╭┫╭╮┃╭╮┃╭╮┃╭╯
┃╰┻━┃┃━┫┃┃┃┃━┫┃┃╭╮┃╰╯┃╰╯┃┃
╰━━━┻━━┻╯╰┻━━┻╯╰╯╰┻━━┻━━┻╯
╭━╮╭━╮╱╱╭╮
┃┃╰╯┃┃╱╭╯╰╮
┃╭╮╭╮┣━┻╮╭╋┳━━┳━━╮
┃┃┃┃┃┃╭╮┃┃┣┫╭╮┃━━┫
┃┃┃┃┃┃╭╮┃╰┫┃╭╮┣━━┃
╰╯╰╯╰┻╯╰┻━┻┻╯╰┻━━╯\e[0m"

echo -e "\e[1;34mGENERADOR DE CONTRASEÑAS\e[0m"

# Función para generar una contraseña segura
generate_password() {
    local name=$1
    local length=12
    local characters="[:alnum:]!@#$%^&*()"
    local password=$(echo "$name" | tr -dc "$characters" | fold -w $length | shuf | head -n 1)
    echo $password
}

# Solicitar al usuario la cantidad de contraseñas a generar
read -p "¿Cuántas contraseñas deseas generar? " quantity

# Crear un archivo para guardar las contraseñas en la tarjeta SD
file="/sdcard/passwords_$(date +"%Y%m%d%H%M%S").txt"

# Generar las contraseñas y guardarlas en el archivo
for ((i=1; i<=quantity; i++)); do
    name=$(shuf -n 1 nombres_latinos.txt)  # nombres_latinos.txt contiene nombres latinos
    password=$(generate_password "$name")
    echo "Contraseña $i: $password"
    echo "Contraseña $i: $password" >> $file
done

echo "Las contraseñas han sido guardadas en $file"