#!/bin/bash
##--------------------------------------------------------------------------------
##
##   ▞▀▖▛▀▖▞▀▖▛▀▖        ▌      Created....: © Destroyer 2025
##   ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌   Description: Toolchain for Amstrad CPC.
##   ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌   Github.....: https://github.com/orgs/CPCReady
##   ▝▀ ▘  ▝▀ ▘ ▘▝▀▘▝▀▘▝▀▘▗▄▘   Doc........: https://cpcready.readthedocs.io/  
##
##-----------------------------LICENSE NOTICE--------------------------------------
##  This file is part of CPCReady Basic programation.
##  Copyright (C) 2025 Destroyer
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##--------------------------------------------------------------------------------



# Función para detectar si el terminal soporta colores
function __cpcready_supports_color() {
  # Verificar si NO estamos en un terminal "dumb" y si el terminal soporta color
  if [[ "$TERM" == "dumb" ]]; then
    return 1
  fi
  
  if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    local colors=$(tput colors 2>/dev/null || echo 0)
    [[ $colors -ge 8 ]]
  else
    return 1
  fi
}

# Función para mostrar el logo de CPCReady con colores y formato.
function __cpcready_logo() {
  version=$(cat $CPCREADY_DIR/var/VERSION)
  echo ""
  echo "==========================================================================="
  echo
  
  if __cpcready_supports_color; then
    # Con colores
    echo -e "\033[1;33m ▞▀▖▛▀▖▞▀▖▛▀▖        ▌   \033[31m    ✴ \033[32mCreated: \033[0m© Destroyer 2025\033[0m" 
    echo -e "\033[1;33m ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌\033[31m    ✴ \033[32mVersion: \033[0m$version\033[0m"
    echo -e "\033[1;33m ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌\033[31m    ✴ \033[32mGithub : \033[0mhttps://github.com/CPCReady\033[0m"
    echo -e "\033[1;33m ▝▀ ▘  ▝▀ ▘ ▘▝▀▘▝▀▘▝▀▘▗▄▘\033[31m    ✴ \033[32mDoc    : \033[0mhttps://cpcready.readthedocs.io/\033[0m" 
  else
    # Sin colores
    echo " ▞▀▖▛▀▖▞▀▖▛▀▖        ▌       ✴ Created: © Destroyer 2025" 
    echo " ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌    ✴ Version: $version"
    echo " ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌    ✴ Github : https://github.com/CPCReady"
    echo " ▝▀ ▘  ▝▀ ▘ ▘▝▀▘▝▀▘▝▀▘▗▄▘    ✴ Doc    : https://cpcready.readthedocs.io/"
  fi
  
  echo ""
  echo "==========================================================================="
  echo
}

# Función para obtener la ruta del proyecto actual usando direnv
# Uso: __cpcready_path
function __cpcready_path() {
    dirname "$(direnv status | grep 'Loaded RC path' | awk '{print $4}')"
}

# Función para imprimir texto en color rojo.
# Uso: __cpcready_echo_red "Este es un mensaje de error"
function __cpcready_echo_red() {
  local text="$1"
  echo -e "\033[1;31m${text}\033[0m"
}

# # Función para actualizar o añadir variables en un archivo de entorno.
# # Uso: update_env <archivo> VAR1=valor1 VAR2=valor2 ...
# update_env() {
#   local CPC_FILE="$1"
#   shift

#   # Si no existe el archivo, lo creamos vacío
#   [ -f "$CPC_FILE" ] || touch "$CPC_FILE"

#   # Creamos fichero temporal en el mismo directorio
#   local TMP_FILE
#   TMP_FILE=$(mktemp "${CPC_FILE}.XXXXXX") || {
#     __cpcready_echo_red "Error: not could create temporary file"
#     return 1
#   }

#   cp "$CPC_FILE" "$TMP_FILE"

#   for ARG in "$@"; do
#     if [[ "$ARG" != *=* ]]; then
#       __cpcready_echo_yellow "Ignoring invalid argument: $ARG"
#       continue
#     fi

#     local KEY="${ARG%%=*}"
#     local VALUE="${ARG#*=}"

#     if grep -q "^${KEY}=" "$TMP_FILE"; then
#       # Reemplazar clave existente
#       sed -i "s|^${KEY}=.*|${KEY}=${VALUE}|" "$TMP_FILE"
#     else
#       # Añadir nueva clave
#       echo "${KEY}=${VALUE}" >> "$TMP_FILE"
#     fi
#   done

#   # Preservar permisos del original
#   chmod --reference="$CPC_FILE" "$TMP_FILE" 2>/dev/null || true

#   # Reemplazar original con el temporal
#   mv "$TMP_FILE" "$CPC_FILE"

#   # Recargar direnv si existe
#   if command -v direnv &>/dev/null; then
#     direnv reload --quiet
#   fi
# }

# Función para mostrar texto en color amarillo
# Uso: __cpcready_echo_yellow "Este es un mensaje de advertencia"
function __cpcready_echo_yellow() {
  local text="$1"
  echo -e "\033[1;33m${text}\033[0m"
}

# Función para mostrar texto en color azul
# Uso: __cpcready_echo_blue "Este es un mensaje informativo"
function __cpcready_echo_blue() {
  local text="$1"
  echo -e "\033[0;34m${text}\033[0m"
}

# Función para mostrar texto en color verde
# Uso: __cpcready_echo_green "Este es un mensaje de éxito"
function __cpcready_echo_green() {
  local text="$1"
  echo -e "\033[0;32m${text}\033[0m"
}

# Función para mostrar texto en color azul
# Uso: __cpcready_echo_blue "Este es un mensaje informativo"
function __cpcready_echo_command_help() {
  local text="$1"
  local description="$2"
  echo -e "\033[0;34m${text}\033[0m${description}"
}

# Función para mostrar un mensaje de error y salir del script.
# Uso: __error_exit "Mensaje de error"
function __error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# Función para verificar si un archivo o directorio existe.
# Uso: if file_exists "mi_archivo.txt"; then ...
function __file_exists() {
  local path="$1"
  if [[ -e "$path" ]]; then
    return 0  # Verdadero (existe)
  else
    return 1  # Falso (no existe)
  fi
}

# funcion que devuelve la version del software
# Uso: __get_version
function __get_version(){
  version=$(cat $CPCREADY_DIR/var/VERSION)
  echo "CPCReady: $version"
  echo
}

# Función para cargar la configuración desde .cpcready.yml
# y exportarla como variables de entorno.
# Uso: __load_config
# function __load_config() {
#   local config_file="$CPCREADY_DIR/.cpcready.yml"
#   if [[ ! -f "$config_file" ]]; then
#     __cpcready_echo_red "Error: Fichero de configuración no encontrado en '$config_file'"
#     return 1
#   fi
#   eval $(yq '. as $item | keys | .[] | "export \(. )=\"\($item[.]\)\""' "$config_file")
# }

# Function to check if CPCREADY_PROJECT_CONFIG is set
# Usage: __cpcready_check_project_config_is_set
__cpcready_check_project_config_is_set() {
  if [ "$CPCREADY" != "PROJECT" ]; then
    __cpcready_echo_red "Error: Project configuration CPCReady project not set."
    __cpcready_echo_red "Please run 'cpc init' to create a new project."
    echo
    exit 1
  fi
}

# Función para mostrar el uso general del comando CPC
# Uso: usage [comando_especifico]
function usage() {
  local command="${1:-}"
  
  if [[ -n "$command" ]]; then
    # Mostrar ayuda específica para un comando
    case "$command" in
      "init")
        echo ""
        echo "Usage: cpc init [options]"
        echo ""
        echo "Initialize a new CPCReady project in the current directory."
        echo ""
        echo "Options:"
        echo "  -h, --help     Show this help message"
        echo "  -v, --version  Show version information"
        echo ""
        echo "Examples:"
        echo "  cpc init        # Initialize project in current directory"
        echo "  cpc init --help # Show this help"
        echo ""
        ;;
      "save")
        echo ""
        echo "Usage: cpc save <filename> [options]"
        echo ""
        echo "Save a file to the virtual disk."
        echo ""
        echo "Options:"
        echo "  -h, --help     Show this help message"
        echo "  -v, --verbose  Verbose output"
        echo "  -d, --dest      Custom destination directory"
        echo ""
        echo "Examples:"
        echo "  cpc save myfile.bas"
        echo "  cpc save myfile.bin --verbose"
        echo "  cpc save myfile.txt --dest /custom/path/"
        echo ""
        ;;
      "run")
        echo ""
        echo "Usage: cpc run <program> [options]"
        echo ""
        echo "Run a program in the CPC emulator."
        echo ""
        echo "Options:"
        echo "  -h, --help     Show this help message"
        echo "  -v, --verbose  Verbose output"
        echo "  -d, --debug    Enable debug mode"
        echo "  -e, --emulator Specify emulator to use"
        echo ""
        echo "Examples:"
        echo "  cpc run myprogram.bin"
        echo "  cpc run game.bas --verbose"
        echo "  cpc run code.bin --debug --emulator custom"
        echo ""
        ;;
      "disc")
        echo ""
        echo "Usage: cpc disc [options] [disc_name]"
        echo ""
        echo "Create and manage virtual disks."
        echo ""
        echo "Options:"
        echo "  -h, --help     Show this help message"
        echo "  -v, --verbose  Verbose output"
        echo "  -s, --size     Disk size (default: 360K)"
        echo "  -f, --format   Disk format (default: dsk)"
        echo ""
        echo "Examples:"
        echo "  cpc disc mydisk          # Create mydisk.dsk"
        echo "  cpc disc --help          # Show this help"
        echo "  cpc disc game --size 720K # Create 720K disk"
        echo ""
        ;;
      "version")
        echo ""
        echo "Usage: cpc version [options]"
        echo ""
        echo "Show version information."
        echo ""
        echo "Options:"
        echo "  -h, --help     Show this help message"
        echo "  -v, --verbose  Show detailed version information"
        echo ""
        echo "Examples:"
        echo "  cpc version"
        echo "  cpc version --verbose"
        echo ""
        ;;
      "help")
        echo ""
        echo "Usage: cpc help [command]"
        echo ""
        echo "Show help information."
        echo ""
        echo "Options:"
        echo "  -h, --help     Show this help message"
        echo ""
        echo "Examples:"
        echo "  cpc help"
        echo "  cpc help save"
        echo "  cpc help run"
        echo ""
        ;;
      "commands")
        echo ""
        echo "Usage: cpc commands"
        echo ""
        echo "List all available commands."
        echo ""
        echo "Examples:"
        echo "  cpc commands" 
        echo ""
        ;;
      *)
        echo "Usage: cpc $command [options]"
        echo ""
        echo "For detailed help on this command, use: cpc $command --help"
        echo ""
        ;;
    esac
  else
    # Mostrar ayuda general
    echo "Usage: cpc <command> [arguments...]"
    echo ""
    echo "CPCReady - Toolchain for Amstrad CPC development"
    echo ""
    echo "Available commands:"
    echo "  commands   - List available commands"
    echo "  disc       - Create a virtual disk"
    echo "  help       - Show help message"
    echo "  init       - Initialize a new project"
    echo "  run        - Run a program in the emulator"
    echo "  save       - Save a file to the virtual disk"
    echo "  version    - Show version information"
    echo ""
    echo "For more details on a specific command, use: cpc <command> --help"
    echo ""
    echo "Examples:"
    echo "  cpc version"
    echo "  cpc help"
    echo "  cpc save myfile.bas"
    echo "  cpc run myprogram.bin"
    echo "  cpc disc mydisk"
    echo ""
  fi
}