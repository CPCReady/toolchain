#!/bin/bash
##--------------------------------------------------------------------------------
##
##   ▞▀▖▛▀▖▞▀▖▛▀▖        ▌      Created....: © Destroyer 2025
##   ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌   Description: Toolchain for Amstrad CPC.
##   ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌   Github.....: https://github.com/CPCReady
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

# Carga la librería de funciones comunes
#!/bin/bash
set -a
source "$CPCREADY_DIR/lib/cpcr-common.sh"
# source "$CPCREADY_CONFIG_FILE"
set +a

# Función para mostrar la ayuda
usage() {
  local BASENAME="$(basename "$0")"
  echo
  if [[ "$BASENAME" == "cpcr-disc" ]]; then
    echo "Usage: cpcr-disc <drive> [disc_name]"
  else
    echo "Usage: cpc disc <drive> [disc_name]"
  fi
  echo
  echo "Manage virtual disk drives for Amstrad CPC development"
  echo
  echo "Arguments:"
  echo "  <drive>        Drive letter to select (A or B)"
  echo "  [disc_name]    Optional: Name of the disk to create/select"
  echo
  echo "Options:"
  echo "  -h, --help     Show this help message"
  echo "  -v, --version  Show version information"
  echo
  echo "Examples:"
  echo "  cpc disc A              # Select drive A"
  echo "  cpc disc B              # Select drive B"
  echo "  cpc disc A mydisk       # Create/select disk 'mydisk' on drive A"
  echo "  cpc disc --help         # Show this help"
  echo
  echo "Description:"
  echo "  This command manages virtual disk drives for CPC development."
  echo "  You can select between drive A and B, and optionally specify"
  echo "  a disk name to create or select a specific virtual disk."
  echo
}


# Función principal para comando disc
function main() {

  # Pasamos variables a mayúsculas para evitar problemas
  DRIVE=$(echo "${1:-}" | tr '[:lower:]' '[:upper:]')
  DISC_NAME=$(echo "${2:-}" | tr '[:lower:]' '[:upper:]')

  # Verificar argumentos pasados
  if [[ -n "$1" && -z "$2" ]]; then
  
      __cpcready_echo_green "Drive $DRIVE selected."
      __cpcready_set_config_file "DRIVE_SELECTED" "$DRIVE"
      __cpcready_config_file

  elif [[ -n "$1" && -n "$2" ]]; then
      __cpcready_echo_green "Drive $DRIVE selected. Disk: $DISC_NAME"
  fi

}

ARG1="${1:-}"
case "$ARG1" in
  A|a|B|b)
    main "$ARG1" "${2:-}"
    ;;
  ""|-h|--help)
    __cpcready_logo
    usage
    exit 0
    ;;
  -v|--version)
    __get_version
    exit 0
    ;;
  *)
    __cpcready_logo
    usage
    exit 0
    ;;
esac

