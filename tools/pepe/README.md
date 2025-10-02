# iDSK - Documentación Completa

## Descripción General

iDSK es una herramienta de línea de comandos diseñada para editar archivos de imagen DSK (Amstrad CPC disk images). Permite añadir y eliminar archivos de las imágenes de disco, así como visualizar archivos BASIC y DAMS que normalmente están en formato tokenizado, no en ASCII plano.

iDSK puede añadir y eliminar cabeceras AMSDOS según sea necesario, proporcionando una interfaz completa para manipular discos virtuales del Amstrad CPC.

## Información del Proyecto

- **Versión**: 0.20
- **Licencia**: MIT License
- **Repositorio**: https://github.com/cpcsdk/idsk
- **Autores**: 
  - Marco Vieth (cpcemu)
  - Ludovic Deplanque (manageDSK)
  - Jérôme Le Saux (Sid) from IMPACT
  - PulkoMandy from the Shinra Team
  - Colin Pitrat
  - Thomas Bernard (miniupnp)
  - Romain Giot (Krusty)
  - Adrien Destugues (PulkoMandy)

## Características Principales

### Funcionalidades Básicas
- **Listar contenido**: Visualizar el catálogo de archivos en una imagen DSK
- **Importar archivos**: Añadir archivos del sistema host al disco virtual
- **Exportar archivos**: Extraer archivos del disco virtual al sistema host
- **Eliminar archivos**: Remover archivos de la imagen DSK
- **Crear nuevos discos**: Generar imágenes DSK vacías

### Visualización de Archivos
- **Archivos BASIC**: Decodificar y mostrar programas BASIC tokenizados
- **Archivos binarios**: Visualización hexadecimal de archivos binarios
- **Archivos ASCII**: Mostrar contenido de archivos de texto
- **Desensamblado**: Desensamblar archivos binarios (Z80)
- **Archivos DAMS**: Soporte para archivos del ensamblador DAMS

### Características Avanzadas
- Soporte completo para cabeceras AMSDOS
- Manejo de diferentes tipos de archivo (ASCII, BINARY, raw)
- Configuración de direcciones de carga y ejecución
- Soporte para números de usuario
- Archivos de solo lectura y del sistema
- Forzado de sobrescritura

## Estructura del Código

### Archivos Principales

#### `Main.cpp` / `Main.h`
- **Propósito**: Punto de entrada principal del programa
- **Funciones clave**:
  - Análisis de argumentos de línea de comandos
  - Coordinación de operaciones principales
  - Función de ayuda (`help()`)
- **Variables globales**: Control de estado del programa

#### `GestDsk.cpp` / `GestDsk.h`
- **Propósito**: Clase principal para manipulación de imágenes DSK
- **Clase principal**: `DSK`
- **Estructuras importantes**:
  - `StAmsdos`: Estructura de entrada AMSDOS
  - `StDirEntry`: Entrada de directorio
  - `CPCEMUEnt`: Cabecera de imagen CPCEMU
  - `CPCEMUTrack`: Información de pista
  - `CPCEMUSect`: Información de sector
- **Funciones clave**:
  - `ReadDsk()`: Lectura de imágenes DSK
  - `WriteDsk()`: Escritura de imágenes DSK
  - `PutFileInDsk()`: Importar archivos
  - `GetFileInDsk()`: Exportar archivos
  - `RemoveFile()`: Eliminar archivos

#### `Basic.cpp` / `Basic.h`
- **Propósito**: Decodificación de archivos BASIC tokenizados
- **Función principal**: `Basic()` - convierte tokens BASIC a texto legible

#### `ViewFile.cpp` / `ViewFile.h`
- **Propósito**: Visualización de diferentes tipos de archivo
- **Funciones**:
  - `ViewBasic()`: Visualizar archivos BASIC
  - `ViewAscii()`: Visualizar archivos ASCII
  - `ViewDesass()`: Desensamblador

#### `Outils.cpp` / `Outils.h`
- **Propósito**: Funciones utilitarias
- **Incluye**: Manipulación de nombres de archivo, conversiones

#### `endianPPC.cpp` / `endianPPC.h`
- **Propósito**: Manejo de endianness para compatibilidad multiplataforma

#### `getopt_pp.cpp` / `getopt_pp.h`
- **Propósito**: Biblioteca para análisis de argumentos de línea de comandos en C++

### Archivos de Soporte

- **`Desass.cpp` / `Desass.h`**: Desensamblador Z80
- **`Dams.cpp` / `Dams.h`**: Soporte para archivos DAMS
- **`Ascii.cpp` / `Ascii.h`**: Manipulación de archivos ASCII
- **`BitmapCPC.cpp` / `BitmapCPC.h`**: Manejo de bitmaps CPC
- **`firmware.h`**: Definiciones del firmware
- **`MyType.h`**: Definiciones de tipos personalizados

## Instalación y Compilación

### Requisitos Previos

#### Linux (Ubuntu/Debian)
```bash
sudo apt update && sudo apt install -y cmake make g++ git
```

#### macOS
```bash
# Asumiendo que Homebrew está instalado (https://brew.sh)
# Puede requerir instalar XCode primero
# xcode-select --install

brew install cmake make 
```

### Proceso de Compilación

```bash
# Clonar el repositorio
git clone https://github.com/cpcsdk/idsk.git
cd idsk

# Crear directorio de compilación
mkdir build && cd build
cmake ..
cmake --build .
```

### Imagen Docker

Para usuarios que prefieren usar Docker, existe una imagen disponible en:
https://github.com/cpcsdk/docker-amstrad-crossdev

## Uso de la Herramienta

### Sintaxis General
```bash
iDSK <archivo_DSK> [OPCIONES] [archivos a procesar]
```

### Opciones Principales

#### Operaciones Básicas
- **`-l`**: Listar catálogo del disco (opción por defecto)
  ```bash
  iDSK floppy.dsk -l
  ```

- **`-n`**: Crear nuevo archivo DSK
  ```bash
  iDSK floppy2.dsk -n
  ```

#### Gestión de Archivos
- **`-i`**: Importar archivo al disco
  ```bash
  iDSK floppy.dsk -i myprog.bas
  ```

- **`-g`**: Exportar archivo del disco
  ```bash
  iDSK floppy.dsk -g myprog.bas
  ```

- **`-r`**: Eliminar archivo del disco
  ```bash
  iDSK floppy.dsk -r myprog.bas
  ```

#### Visualización de Archivos
- **`-b`**: Listar archivo BASIC
  ```bash
  iDSK floppy.dsk -b myprog.bas
  ```

- **`-a`**: Listar archivo ASCII
  ```bash
  iDSK floppy.dsk -a myprog.txt
  ```

- **`-h`**: Listar archivo binario en hexadecimal
  ```bash
  iDSK floppy.dsk -h myprog.bin
  ```

- **`-z`**: Desensamblar archivo binario
  ```bash
  iDSK floppy.dsk -z myprog.bin
  ```

- **`-d`**: Listar archivo DAMS
  ```bash
  iDSK floppy.dsk -d myprog.dms
  ```

### Opciones Avanzadas para Importación

- **`-t`**: Tipo de archivo (0=ASCII/1=BINARY/2=raw)
  ```bash
  iDSK floppy.dsk -i myprog.bin -t 1
  ```

- **`-e`**: Dirección de ejecución (hexadecimal)
  ```bash
  iDSK floppy.dsk -i myprog.bin -e C000 -t 1
  ```

- **`-c`**: Dirección de carga (hexadecimal)
  ```bash
  iDSK floppy.dsk -i myprog.bin -e C000 -c 4000 -t 1
  ```

- **`-f`**: Forzar sobrescritura si el archivo existe
  ```bash
  iDSK floppy.dsk -i myprog.bas -f
  ```

- **`-o`**: Insertar archivo de solo lectura
  ```bash
  iDSK floppy.dsk -i myprog.bas -o
  ```

- **`-s`**: Insertar archivo del sistema
  ```bash
  iDSK floppy.dsk -i myprog.bas -s
  ```

- **`-u`**: Insertar archivo con número de usuario específico
  ```bash
  iDSK floppy.dsk -i myprog.bas -u 3
  ```

- **`-p`**: Dividir líneas después de 80 caracteres
  ```bash
  iDSK floppy.dsk -b myprog.bas -p
  ```

## Ejemplos de Uso

### Crear un nuevo disco y añadir archivos
```bash
# Crear nuevo disco
iDSK mydisk.dsk -n

# Añadir un programa BASIC
iDSK mydisk.dsk -i game.bas -t 0

# Añadir un archivo binario con direcciones específicas
iDSK mydisk.dsk -i loader.bin -t 1 -c 8000 -e 8000

# Listar contenido del disco
iDSK mydisk.dsk -l
```

### Extraer archivos de un disco existente
```bash
# Listar contenido
iDSK game.dsk -l

# Extraer un programa BASIC
iDSK game.dsk -g mygame.bas

# Extraer múltiples archivos
iDSK game.dsk -g file1.bin
iDSK game.dsk -g file2.bas
```

### Analizar contenido de archivos
```bash
# Ver código BASIC decodificado
iDSK game.dsk -b mygame.bas

# Ver contenido hexadecimal de un binario
iDSK game.dsk -h loader.bin

# Desensamblar un archivo binario
iDSK game.dsk -z code.bin
```

## Formato de Imagen DSK

iDSK trabaja con el formato CPCEMU DSK, que es un estándar para imágenes de disco del Amstrad CPC. Las características incluyen:

- **Tamaño estándar**: 178KB (40 pistas, 1 cabeza, 9 sectores por pista)
- **Tamaño de sector**: 512 bytes
- **Sistema de archivos**: CP/M compatible con extensiones AMSDOS
- **Soporte para cabeceras AMSDOS**: Metadatos de archivo incluyendo direcciones de carga/ejecución

### Estructura de Archivo AMSDOS

Los archivos en imágenes DSK pueden tener cabeceras AMSDOS que contienen:
- Dirección de carga
- Dirección de ejecución
- Longitud del archivo
- Tipo de archivo
- Checksum

## Limitaciones Conocidas

- Los archivos DAMS aún no están completamente implementados
- Soporte limitado para formatos de disco no estándar
- La funcionalidad de desensamblado está orientada específicamente al Z80

## Desarrollo y Contribución

### Estructura del Sistema de Build

El proyecto utiliza CMake como sistema de build:
- **`CMakeLists.txt`**: Configuración principal de CMake
- **Directorio `build/`**: Contiene archivos generados por la compilación
- **Archivos de configuración**: Cache de CMake y makefiles generados

### Compiladores Soportados
- GCC (Linux)
- Clang (macOS)
- Probablemente MSVC (Windows, no documentado específicamente)

## Soporte y Reporte de Errores

Para reportar errores o solicitar características:
- **Repositorio GitHub**: https://github.com/cpcsdk/idsk
- **Mantener**: Demoniak, Sid, PulkoMandy

## Referencias

- [Documentación del formato DSK](http://www.cpcwiki.eu/index.php/Disk_structure)
- [CPCSDK - Amstrad CPC SDK](https://github.com/cpcsdk)
- [CPCWiki - Recurso principal para Amstrad CPC](http://www.cpcwiki.eu/)

---

*Documentación generada a partir del análisis del código fuente de iDSK v0.20*