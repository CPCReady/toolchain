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

# Función para mostrar ayuda del comando run
show_run_help() {
    echo "Usage: cpc run <program> [options]"
    echo ""
    echo "Run a program in the CPC emulator"
    echo ""
    echo "Options:"
    echo "  -h, --help       Show this help message"
    echo "  -v, --verbose    Show verbose output"
    echo "  -e, --emulator   Specify emulator (default: auto-detect)"
    echo "  -d, --debug      Run in debug mode"
    echo ""
    echo "Examples:"
    echo "  cpc run myprogram.bin"
    echo "  cpc run game.bas --verbose"
    echo "  cpc run code.bin --debug"
}

# Verificar si se solicita ayuda
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_run_help
    exit 0
fi

echo "Ejecutando la acción 'RUN'..."

# Verificar que se proporcionó un programa
if [ -z "$1" ]; then
    echo "Error: Se necesita un nombre de programa para 'RUN'."
    echo ""
    show_run_help
    exit 1
fi

PROGRAM_TO_RUN="$1"
VERBOSE=false
DEBUG=false
EMULATOR="auto"

# Procesar argumentos adicionales
shift
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -d|--debug)
            DEBUG=true
            shift
            ;;
        -e|--emulator)
            EMULATOR="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            show_run_help
            exit 1
            ;;
    esac
done

# Mostrar información si verbose está activado
if [[ "$VERBOSE" == true ]]; then
    echo "Verbose mode enabled"
    echo "Program to run: $PROGRAM_TO_RUN"
    echo "Emulator: $EMULATOR"
    echo "Debug mode: $DEBUG"
fi

# Verificar que el programa existe
if [[ ! -f "$PROGRAM_TO_RUN" ]]; then
    echo "Error: Program '$PROGRAM_TO_RUN' not found."
    exit 1
fi

# Determinar el tipo de archivo
file_extension="${PROGRAM_TO_RUN##*.}"
case "$file_extension" in
    bas|BAS)
        program_type="BASIC"
        ;;
    bin|BIN)
        program_type="Binary"
        ;;
    *)
        program_type="Unknown"
        ;;
esac

echo "Running $program_type program: '$PROGRAM_TO_RUN'"

if [[ "$DEBUG" == true ]]; then
    echo "Debug mode enabled - launching with debugger..."
fi

# Aquí iría la lógica real para ejecutar el programa en el emulador
# Ejemplo: emulator_command "$PROGRAM_TO_RUN"

if [[ "$VERBOSE" == true ]]; then
    echo "Run operation completed."
fi