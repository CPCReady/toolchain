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

# Función para mostrar ayuda del comando save
show_save_help() {
    echo "Usage: cpc save <filename> [options]"
    echo ""
    echo "Save a file to the CPC virtual disk"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --verbose  Show verbose output"
    echo "  -d, --dest     Destination directory (default: ~/.cpc/saved_files/)"
    echo ""
    echo "Examples:"
    echo "  cpc save myfile.bas"
    echo "  cpc save myfile.bin --verbose"
    echo "  cpc save myfile.txt --dest /path/to/dest"
}

# Verificar si se solicita ayuda
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_save_help
    exit 0
fi

echo "Ejecutando la acción 'SAVE'..."

# Verificar que se proporcionó un archivo
if [ -z "$1" ]; then
    echo "Error: Se necesita un nombre de archivo para 'SAVE'."
    echo ""
    show_save_help
    exit 1
fi

FILE_TO_SAVE="$1"
VERBOSE=false
DEST_DIR="$HOME/.cpc/saved_files/"

# Procesar argumentos adicionales
shift
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -d|--dest)
            DEST_DIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            show_save_help
            exit 1
            ;;
    esac
done

# Mostrar información si verbose está activado
if [[ "$VERBOSE" == true ]]; then
    echo "Verbose mode enabled"
    echo "File to save: $FILE_TO_SAVE"
    echo "Destination directory: $DEST_DIR"
fi

# Verificar que el archivo existe
if [[ ! -f "$FILE_TO_SAVE" ]]; then
    echo "Error: File '$FILE_TO_SAVE' not found."
    exit 1
fi

# Crear directorio destino si no existe
mkdir -p "$DEST_DIR"

# Simular la operación de guardado
echo "Saving '$FILE_TO_SAVE' to '$DEST_DIR'..."

# Ejemplo de acción real (descomentado para uso real):
# cp "$FILE_TO_SAVE" "$DEST_DIR"

if [[ "$VERBOSE" == true ]]; then
    echo "Save operation completed successfully."
fi