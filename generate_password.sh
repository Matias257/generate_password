#!/bin/bash

echo -e "\e[1;33m
╔═══╗───────────────╔╗───────╔╗
║╔═╗║───────────────║║───────║║
║║─╚╬══╦═╗╔══╦═╦══╦═╝╠══╦═╗╔═╝╠══╗
║║╔═╣║═╣╔╗╣║═╣╔╣╔╗║╔╗║╔╗║╔╝║╔╗║║═╣
║╚╩═║║═╣║║║║═╣║║╔╗║╚╝║╚╝║║─║╚╝║║═╣
╚═══╩══╩╝╚╩══╩╝╚╝╚╩══╩══╩╝─╚══╩══╝
╔═══╗─────╔╗
║╔═╗║────╔╝╚╗
║║─╚╬══╦═╬╗╔╬═╦══╦══╦══╦═╗╔══╦══╗
║║─╔╣╔╗║╔╗╣║║╔╣╔╗║══╣║═╣╔╗╣╔╗║══╣
║╚═╝║╚╝║║║║╚╣║║╔╗╠══║║═╣║║║╔╗╠══║
╚═══╩══╩╝╚╩═╩╝╚╝╚╩══╩══╩╝╚╩╝╚╩══╝\e[0m"

echo -e "\e[36mCreador Matias\e[0m"

# Función para generar contraseñas seguras
generate_password() {
    pass=$(openssl rand -base64 12 | tr -dc 'a-zA-Z0-9' | head -c 16)
    echo $pass
}

# Función para generar contraseñas con nombres latinos
generate_name_password() {
    name=$1
    pass=$(generate_password)
    echo "${name}_${pass}"
}

# Crear un directorio en el directorio home para almacenar las contraseñas
output_dir="$HOME/contraseñas"
mkdir -p $output_dir

# Instrucciones para el usuario
echo "Este script te ayudará a generar contraseñas seguras con nombres latinos y guardarlas en archivos."

# Bucle para generar contraseñas
while true
do
    # Pedir al usuario la cantidad de contraseñas a generar
    read -p "Ingrese la cantidad de contraseñas a generar: " cantidad

    # Generar contraseñas con nombres latinos y guardarlas en archivos
    for ((i=1; i<=$cantidad; i++))
    do
        read -p "Ingrese un nombre latino para la contraseña $i: " nombre
        password=$(generate_name_password $nombre)
        echo $password > "$output_dir/contraseña_$i.txt"
    done

    echo "Contraseñas generadas y guardadas en $output_dir"

    # Preguntar al usuario si desea seguir generando contraseñas
    read -p "¿Desea generar más contraseñas? (s/n): " continuar
    if [ "$continuar" != "s" ]; then
        break
    fi
done