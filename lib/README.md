# cpc-common.sh

Este script proporciona un conjunto de funciones de utilidad comunes para los scripts de `CPCReady`.

## Funciones

A continuación se detallan las funciones disponibles en este script:

### Colores para la salida de texto

Estas funciones se utilizan para imprimir texto en diferentes colores en la terminal.

- `__cpcready_echo_red "texto"`: Imprime el texto en color rojo. Útil para mensajes de error.
- `__cpcready_echo_yellow "texto"`: Imprime el texto en color amarillo. Útil para advertencias.
- `__cpcready_echo_blue "texto"`: Imprime el texto en color azul. Útil para mensajes informativos.
- `__cpcready_echo_green "texto"`: Imprime el texto en color verde. Útil para mensajes de éxito.
- `__cpcready_echo_command_help "comando" "descripción"`: Imprime el nombre de un comando en azul seguido de su descripción.

### Funciones de utilidad

- `__error_exit "mensaje de error"`: Muestra un mensaje de error y termina la ejecución del script con un código de salida de 1.
- `__file_exists "/ruta/al/fichero_o_directorio"`: Comprueba si un fichero o directorio existe. Devuelve 0 si existe y 1 si no.
- `__get_version`: Muestra la versión actual de `CPCReady` obteniéndola del fichero `var/VERSION`.
- `__load_config`: Carga la configuración desde el fichero `.cpcready.yml` y exporta las claves como variables de entorno. Requiere que `yq` esté instalado.
- `__cpcready_check_project_config_is_set`: Comprueba si la variable de entorno `CPCREADY_PROJECT_CONFIG` está definida, mostrando un error si no lo está.

## Uso

Para utilizar estas funciones en otros scripts de bash, simplemente incluya este script al principio del suyo:

```bash
source /ruta/a/cpc-common.sh
```
