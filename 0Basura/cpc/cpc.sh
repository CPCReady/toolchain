#!/bin/bash
##--------------------------------------------------------------------------------
##
##   ▞▀▖▛▀▖▞▀▖▛▀▖        ▌      Created....: © Destroyer 2025
##   ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌   Description: Projects creation CPCReady
##   ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌   Github.....: https://github.com/CPCReady/cpc
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
set -e

VERSION="0.1.0"

#CPC_COMMON="$(brew --prefix)/opt/cpcready-tools/libexec/cpc-common.sh"
CPC_COMMON="/home/destroyer/Projects/CPCReady3/cpc-common/cpc-common.sh"
source "$CPC_COMMON"

usage() {
  __cpcready_logo "cpc" "$VERSION"
  echo "Usage: $(basename "$0") [COMMAND] [OPTIONS]"
  echo
  echo "Modifies or adds one or more environment variables in the .cpc file and reloads direnv."
  echo
  echo "Commands:"
  echo "  init          Initialize a new project."
  echo "  -h, --help    Show this help."
  echo "  -v, --version Show the script version."
  echo
  echo "Options:"
  echo "  KEY=VALUE     One or more variables to update. If KEY exists, it is modified. If not, it is added."
  echo
  echo "Examples:"
  echo "  $(basename "$0") init"
  echo "  $(basename "$0") CPC=464 MODE=1"
  echo "  $(basename "$0") --help"
  echo
}

case "$1" in
  ""|-h|--help)
    usage
    exit 0
    ;;
  -v|--version)
    echo "v$VERSION"
    exit 0
    ;;
  init)
    if [[ -f ".cpcd" ]]; then
      echo
      echo "CPCReady project already exists in this directory."
      echo
      exit 1
    fi
    touch .cpc

    CONFIG_FILE=~/.config/direnv/direnv.toml
    if [[ -f "$CONFIG_FILE" ]]; then
      # Primero, comprobar si la línea 'log_filter' ya existe para no duplicarla
      if ! grep -q 'log_filter="^$"' "$CONFIG_FILE"; then
        # Si no existe, comprobar si la sección '[global]' existe
        if grep -q '^\\[global\\]' "$CONFIG_FILE"; then
          # Si '[global]' existe, insertar 'log_filter' justo debajo
          sed -i '/^\\[global\\]/a log_filter="^$"' "$CONFIG_FILE"
        else
          # Si '[global]' no existe, añadir la sección y la línea al final del fichero
          echo -e "\n[global]\nlog_filter=\"^$\"" >> "$CONFIG_FILE"
        fi
      fi
    else
      # Asegurarse de que el directorio y el fichero de configuración existen
      mkdir -p "$(dirname "$CONFIG_FILE")"
      touch "$CONFIG_FILE"
      echo "[global]" > ~/.config/direnv/direnv.toml
      echo 'log_filter="^$"' >> ~/.config/direnv/direnv.toml
    fi
    # if [ -f ~/.bashrc ]; then
    #   echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
    # fi

    # if [ -f ~/.zshrc ]; then
    #   echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
    # fi
    echo "dotenv .cpc" > .envrc
    direnv allow
    cpc-update-var SELECTED_DRIVE=A
    gum spin --spinner dot --title "Initializing CPCReady project..." -- sleep 1
    exit 0
    ;;
esac
