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
  if [[ -f ".cpc" ]]; then
    echo
    __cpcready_echo_red "CPCReady project already exists in this directory."
    echo
    exit 1
  fi

  touch .cpc
  # Create variables in .cpc
  cpc-config .cpc CPCREADY PROJECT
  cpc-config .cpc DRIVE_SELECT A
  cpc-config .cpc DRIVE_A ""
  cpc-config .cpc DRIVE_B ""
  
  cp "$CPCREADY_DIR/cfg/envrc" .envrc
  # Activate direnv
  direnv allow

  gum spin --spinner dot --title "Initializing CPCReady project..." -- sleep 1
  __cpcready_echo_green "CPCReady project initialized successfully."
  echo

  exit 0
}

case "$1" in
  "")
    main
    ;;
  -h|--help)
    usage "init"
    exit 0
    ;;
  -v|--version)
    echo "v$VERSION"
    exit 0
    ;;
  *)
    usage "init"
    exit 0
    ;;
esac