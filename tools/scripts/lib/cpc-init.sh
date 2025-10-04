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
    if [[ -f ".cpc" ]]; then
      echo
      echo "CPCReady project already exists in this directory."
      echo
      exit 1
    fi
    touch .cpc
    echo "oaasdfas"
    CONFIG_FILE=~/.config/direnv/direnv.toml
    
    if [[ -f "$CONFIG_FILE" ]]; then
      cpc-ini set $CONFIG_FILE global log_filter '"^$"'
    else
      # Asegurarse de que el directorio y el fichero de configuración existen
      mkdir -p "$(dirname "$CONFIG_FILE")"
      touch "$CONFIG_FILE"
      cpc-ini set $CONFIG_FILE global log_filter '"^$"'
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