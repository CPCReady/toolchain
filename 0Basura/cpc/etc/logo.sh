#!/bin/bash

# Carga la librería de funciones comunes
source "$CPCREADY_DIR/lib/cpcready-common.sh"

version=$(cat $CPCREADY_DIR/var/VERSION)

echo ""
echo "========================================================================="
echo
echo -e "${YELLOW_BOLD} ▞▀▖▛▀▖▞▀▖▛▀▖        ▌   ${RED}    ✴ ${GREEN}Created: ${RESET}© Destroyer 2025${RESET}" 
echo -e "${YELLOW_BOLD} ▌  ▙▄▘▌  ▙▄▘▞▀▖▝▀▖▞▀▌▌ ▌${RED}    ✴ ${GREEN}Version: ${RESET}$version${RESET}"
echo -e "${YELLOW_BOLD} ▌ ▖▌  ▌ ▖▌▚ ▛▀ ▞▀▌▌ ▌▚▄▌${RED}    ✴ ${GREEN}Github : ${RESET}https://github.com/CPCReady/${RESET}"
echo -e "${YELLOW_BOLD} ▝▀ ▘  ▝▀ ▘ ▘▝▀▘▝▀▘▝▀▘▗▄▘${RED}    ✴ ${GREEN}Doc    : ${RESET}https://cpcready.readthedocs.io/${RESET}" 
echo
echo "========================================================================="
