# CPC Wrapper - Documentación

## Descripción

El script `cpc.sh` actúa como un wrapper (envoltorio) que permite ejecutar los diferentes comandos `cpc-*` de forma unificada, pasando el nombre del comando como parámetro. Es compatible con bash y zsh.

## Uso

```bash
./cpc.sh <comando> [argumentos...]
```

## Comandos Disponibles

Los comandos disponibles corresponden a los scripts en `lib/cpc-*.sh`:

- **commands** - Lista todos los comandos disponibles
- **disc** - Crear un disco virtual (con opciones avanzadas)
- **help** - Mostrar mensaje de ayuda
- **run** - Ejecutar un programa en el emulador (con opciones de debug)
- **save** - Guardar un archivo en el disco virtual (con opciones de destino)
- **version** - Mostrar información de versión (con modo verbose)

## Ejemplos de Uso

### Mostrar ayuda general
```bash
./cpc.sh
./cpc.sh help
```

### Listar comandos disponibles
```bash
./cpc.sh commands
```

### Mostrar versión
```bash
./cpc.sh version
./cpc.sh version --verbose    # Información adicional
```

### Mostrar ayuda de comandos específicos
```bash
./cpc.sh save --help
./cpc.sh run --help
./cpc.sh disc --help
```

### Crear un disco virtual
```bash
./cpc.sh disc mydisk          # Crear mydisk.dsk
./cpc.sh disc --help          # Ver opciones
```

### Guardar un archivo
```bash
./cpc.sh save myfile.bas
./cpc.sh save myfile.bin --verbose
./cpc.sh save myfile.txt --dest /custom/path/
```

### Ejecutar un programa
```bash
./cpc.sh run myprogram.bin
./cpc.sh run game.bas --verbose
./cpc.sh run code.bin --debug --emulator custom
```

## Características de los Comandos

### save
- **Parámetros**: `<filename> [options]`
- **Opciones**:
  - `-h, --help`: Mostrar ayuda
  - `-v, --verbose`: Salida detallada
  - `-d, --dest`: Directorio destino personalizado
- **Funcionalidad**: Valida archivos, crea directorios, manejo de errores

### run
- **Parámetros**: `<program> [options]`
- **Opciones**:
  - `-h, --help`: Mostrar ayuda
  - `-v, --verbose`: Salida detallada
  - `-e, --emulator`: Especificar emulador
  - `-d, --debug`: Modo debug
- **Funcionalidad**: Detecta tipo de archivo, manejo de emuladores

### version
- **Parámetros**: `[--verbose]`
- **Opciones**:
  - `-v, --verbose`: Información adicional del sistema
- **Funcionalidad**: Muestra versión, información del entorno

### disc
- **Parámetros**: `[disc_name] [options]`
- **Opciones**: Ver `./cpc.sh disc --help`
- **Funcionalidad**: Creación y gestión de discos virtuales

## Estructura del Wrapper

El wrapper funciona de la siguiente manera:

1. **Detección del shell**: Compatible con bash y zsh
2. **Detección del directorio**: Determina automáticamente la ubicación del script
3. **Configuración de variables**: Establece `CPCREADY_DIR` para que los scripts puedan encontrar las librerías
4. **Validación de comandos**: Verifica que el comando solicitado existe
5. **Ejecución**: Ejecuta el script correspondiente con los argumentos proporcionados

## Manejo de Errores

- Si no se proporciona ningún comando, muestra la ayuda
- Si el comando no existe, muestra un error y la lista de comandos disponibles
- Cada comando valida sus propios parámetros y muestra ayuda específica
- Los errores de los scripts individuales se propagan al usuario

## Compatibilidad de Shells

### Bash
```bash
bash cpc.sh comando [args...]
```

### Zsh
```bash
zsh -c 'bash cpc.sh comando [args...]'
```

### Ejecución directa (requiere permisos)
```bash
./cpc.sh comando [args...]
```

## Ventajas del Wrapper

1. **Interfaz unificada**: Un solo punto de entrada para todos los comandos
2. **Simplicidad**: `cpc comando` en lugar de `cpc-comando.sh`
3. **Autoconfigurable**: Detecta automáticamente las rutas necesarias
4. **Extensible**: Nuevos comandos se añaden automáticamente
5. **Manejo de errores**: Validación y mensajes informativos
6. **Ayuda integrada**: Cada comando tiene su propia ayuda
7. **Compatibilidad**: Funciona en bash y zsh
8. **Parámetros avanzados**: Soporte completo para opciones y argumentos

## Instalación y Configuración

1. Asegurarse de que `cpc.sh` es ejecutable:
   ```bash
   chmod +x cpc.sh
   ```

2. Asegurarse de que todos los scripts en `lib/` son ejecutables:
   ```bash
   chmod +x lib/*.sh
   ```

3. Opcionalmente, crear un alias para uso frecuente:
   ```bash
   alias cpc='/ruta/completa/al/cpc.sh'
   ```

4. O crear un enlace simbólico para uso global:
   ```bash
   ln -s /ruta/completa/al/cpc.sh /usr/local/bin/cpc
   ```

## Variables de Entorno

El wrapper establece automáticamente:
- `CPCREADY_DIR`: Directorio base de cpcready (directorio del script)

## Estructura de Archivos Esperada

```
scripts/
├── cpc.sh                    # Wrapper principal
├── README_cpc_wrapper.md     # Esta documentación
└── lib/
    ├── cpc-common.sh         # Funciones comunes
    ├── cpc-commands.sh       # Listar comandos
    ├── cpc-disc.sh           # Gestión de discos
    ├── cpc-help.sh           # Ayuda general
    ├── cpc-run.sh            # Ejecutar programas
    ├── cpc-save.sh           # Guardar archivos
    └── cpc-version.sh        # Información de versión
```

## Desarrollo y Extensión

Para añadir un nuevo comando:

1. Crear un nuevo script `lib/cpc-nuevo.sh`
2. Incluir soporte para `--help`
3. Usar las funciones comunes de `cpc-common.sh`
4. El wrapper lo detectará automáticamente

### Plantilla para nuevos comandos

```bash
#!/bin/bash

# Carga la librería de funciones comunes
source "$CPCREADY_DIR/lib/cpc-common.sh"

# Función para mostrar ayuda
show_help() {
    echo "Usage: cpc nuevo [options]"
    echo ""
    echo "Descripción del nuevo comando"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo ""
}

# Verificar si se solicita ayuda
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Lógica del comando
echo "Ejecutando nuevo comando..."

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done
```