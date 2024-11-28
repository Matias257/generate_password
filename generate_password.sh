#!/bin/bash

# Función para generar contraseñas seguras
generate_password() {
    pwgen -s 16 1
}

# Función para generar contraseñas con nombres latinos
generate_name_password() {
    local name="$1"
    local pass=$(generate_password)
    echo "${name}_${pass}"
}

# Crear directorio para almacenar las contraseñas
output_dir="$HOME/contraseñas"
mkdir -p "$output_dir" || { echo "Error al crear el directorio de contraseñas"; exit 1; }

# Mensaje para el usuario
echo "Este script generará contraseñas seguras con nombres latinos y las guardará en archivos en $output_dir."

while true; do
    read -p "Ingrese la cantidad de contraseñas a generar: " cantidad

    if ! [[ "$cantidad" =~ ^[0-9]+$ ]]; then
        echo "Por favor, ingrese un número válido."
        continue
    fi

    for ((i=1; i<=$cantidad; i++)); do
        read -p "Ingrese un nombre latino para la contraseña $i: " nombre
        password=$(generate_name_password "$nombre")
        echo "$password" > "$output_dir/contraseña_$i.txt"
    done

    echo "Contraseñas generadas y guardadas en $output_dir."

    read -p "¿Desea generar más contraseñas? (s/n): " continuar
    if [ "$continuar" != "s" ]; then
        break
    fi
done