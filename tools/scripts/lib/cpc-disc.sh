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

  # Check if a project configuration is loaded.
  echo
  __cpcready_check_project_config_is_set
  if [ $? -ne 0 ]; then
    echo
    return 1
  fi
  
}

# Manejo de argumentos
case "$1" in
  ""|-h|--help)
    usage "init"
    exit 0
    ;;
  -v|--version)
    echo "v$VERSION"
    exit 0
    ;;
  init)
    main
    ;;
esac

exit


# Main function of the script.
main() {

  # Check if a project configuration is loaded.
  echo
  __cpcready_check_project_config_is_set
  if [ $? -ne 0 ]; then
    echo
    return 1
  fi

  # If no argument is provided, set storage_select to DISC.
  if [ -z "$1" ]; then
    if $YQ -i '.storage_select = "DISC"' "$CPCREADY_PROJECT_CONFIG"; then
      echo "Disc Ready"
      echo
    else
      __cpcready_echo_red "Error modifying the configuration file."
      echo
      return 1
    fi

  else
    # An argument is provided, so we are creating a disc.
    # Convert the disc name to uppercase.
    VIRTUAL_DISC=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    
    # Add .dsk extension if not present.
    if [[ "$VIRTUAL_DISC" != *.DSK ]]; then
      VIRTUAL_DISC="${VIRTUAL_DISC}.dsk"
    fi

    # Check if the disc file already exists.
    if [ -f "$VIRTUAL_DISC" ]; then
      # File exists, ask to overwrite.
      if gum confirm "Disc file '$VIRTUAL_DISC' already exists. Overwrite?"; then
        # Overwrite confirmed, create the disc.
        if $IDSK "$VIRTUAL_DISC" -n -f; then
          echo "Disc $VIRTUAL_DISC createdw"
          echo
        else
          __cpcready_echo_red "Error: Could not set virtual disc to '$VIRTUAL_DISC'."
          return 1
        fi
      else
        # Overwrite denied.
        __cpcready_echo_red "Disc file not created."
        echo
        return 1
      fi
    else
      # File does not exist, create it.
      if $IDSK "$VIRTUAL_DISC" -n -f; then
        echo "Disc $VIRTUAL_DISC created"
        echo
      else
        __cpcready_echo_red "Error: Could not create virtual disc '$VIRTUAL_DISC'."
        echo
        return 1
      fi
    fi

  fi
}

# Run the main function with all script arguments.
main "$@"