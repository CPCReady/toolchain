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

# Carga la librería de funciones comunes
source "$CPCREADY_DIR/lib/cpc-common.sh"
echo 
__cpcready_echo_green "Available commands:"
echo""
__cpcready_echo_command_help "  disc       " "Create a virtual disk"
__cpcready_echo_command_help "  commands   " "List available commands"
__cpcready_echo_command_help "  run        " "Run a program in the emulator"
__cpcready_echo_command_help "  save       " "Save a file to the virtual disk"
__cpcready_echo_command_help "  help       " "Show this help message"
__cpcready_echo_command_help "  version    " "Show the software version"
echo ""

# Ejemplo de acción:
# cp "$FILE_TO_SAVE" "$HOME/.cpc/saved_files/"

