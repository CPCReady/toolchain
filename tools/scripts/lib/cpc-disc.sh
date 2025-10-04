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
source "$CPCREADY_DIR/lib/cpc-common.sh"

# Función principal para comando init
function main() {

  local DRIVE="$1"
  local DISC_NAME="$2"

  # Check if a project configuration is loaded.
  __cpcready_check_project_config_is_set

  if [[ -z "$DISC_NAME" ]]; then
    cpc-config .cpc DRIVE_SELECT $DRIVE
    __cpcready_echo_green "Drive $DRIVE selected."
  fi
}

case "$1" in
  A|a|B|b)
    main "$1"
    ;;
  ""|-h|--help)
    usage "disc"
    exit 0
    ;;
  -v|--version)
    __get_version

    exit 0
    ;;
  *)
    usage "disc"
    exit 0
    ;;
esac