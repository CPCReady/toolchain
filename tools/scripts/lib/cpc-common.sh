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

RED='\e[31m'
BLUE='\e[34m'
GREEN='\e[32m'
YELLOW='\e[33m'
YELLOW_BOLD='\e[1;33m'
RESET='\e[0m'


# Función para mostrar el logo de CPCReady con colores y formato.
# Uso: __cpcready_logo "cpc" "1.0.0"
function __cpcready_logo() {
  echo ""
  echo "==========================================================================="
  echo
  echo -e "${YELLOW_BOLD} ▞▀▖▛▀▖▞▀▖▛▀▖        ▌   ${RED}    ✴ ${GREEN}Created: ${RESET}© Destroyer 2025${RESET}" 
  echo -e "${YELLOW_BOLD} ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌${RED}    ✴ ${GREEN}Version: ${RESET}$2${RESET}"
  echo -e "${YELLOW_BOLD} ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌${RED}    ✴ ${GREEN}Github : ${RESET}https://github.com/CPCReady/$1${RESET}"
  echo -e "${YELLOW_BOLD} ▝▀ ▘  ▝▀ ▘ ▘▝▀▘▝▀▘▝▀▘▗▄▘${RED}    ✴ ${GREEN}Doc    : ${RESET}https://cpcready.readthedocs.io/${RESET}" 
  echo ""
  echo "==========================================================================="
  echo
}

# Función para imprimir texto en color rojo.
# Uso: __cpcready_echo_red "Este es un mensaje de error"
function __cpcready_echo_red() {
  local text="$1"
  echo -e "\033[0;31m${text}\033[0m"
}

# Función para actualizar o añadir variables en un archivo de entorno.
# Uso: update_env <archivo> VAR1=valor1 VAR2=valor2 ...
update_env() {
  local CPC_FILE="$1"
  shift

  # Si no existe el archivo, lo creamos vacío
  [ -f "$CPC_FILE" ] || touch "$CPC_FILE"

  # Creamos fichero temporal en el mismo directorio
  local TMP_FILE
  TMP_FILE=$(mktemp "${CPC_FILE}.XXXXXX") || {
    __cpcready_echo_red "Error: not could create temporary file"
    return 1
  }

  cp "$CPC_FILE" "$TMP_FILE"

  for ARG in "$@"; do
    if [[ "$ARG" != *=* ]]; then
      __cpcready_echo_yellow "Ignoring invalid argument: $ARG"
      continue
    fi

    local KEY="${ARG%%=*}"
    local VALUE="${ARG#*=}"

    if grep -q "^${KEY}=" "$TMP_FILE"; then
      # Reemplazar clave existente
      sed -i "s|^${KEY}=.*|${KEY}=${VALUE}|" "$TMP_FILE"
    else
      # Añadir nueva clave
      echo "${KEY}=${VALUE}" >> "$TMP_FILE"
    fi
  done

  # Preservar permisos del original
  chmod --reference="$CPC_FILE" "$TMP_FILE" 2>/dev/null || true

  # Reemplazar original con el temporal
  mv "$TMP_FILE" "$CPC_FILE"

  # Recargar direnv si existe
  if command -v direnv &>/dev/null; then
    direnv reload --quiet
  fi
}

# Función para mostrar texto en color amarillo
# Uso: __cpcready_echo_yellow "Este es un mensaje de advertencia"
function __cpcready_echo_yellow() {
  local text="$1"
  echo -e "\033[0;33m${text}\033[0m"
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
}

# Función para cargar la configuración desde .cpcready.yml
# y exportarla como variables de entorno.
# Uso: __load_config
function __load_config() {
  local config_file="$CPCREADY_DIR/.cpcready.yml"
  if [[ ! -f "$config_file" ]]; then
    __cpcready_echo_red "Error: Fichero de configuración no encontrado en '$config_file'"
    return 1
  fi
  eval $(yq '. as $item | keys | .[] | "export \(. )=\"\($item[.]\)\""' "$config_file")
}

# Function to check if CPCREADY_PROJECT_CONFIG is set
# Usage: __cpcready_check_project_config_is_set
__cpcready_check_project_config_is_set() {
  if [ -z "$CPCREADY_PROJECT_CONFIG" ]; then
    __cpcready_echo_red "Error: Project configuration CPCReady project not set."
    __cpcready_echo_red "Please run 'cpc init' to create a new project."
    return 1
  fi
}