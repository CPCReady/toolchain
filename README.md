# CPCReady Toolchain

🚀 **Toolchain completo para desarrollo en Amstrad CPC**

[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![GitHub](https://img.shields.io/badge/GitHub-CPCReady-blue)](https://github.com/CPCReady)

## 📖 Descripción

CPCReady Toolchain es un conjunto de herramientas para el desarrollo de software para Amstrad CPC. Incluye utilidades para crear discos virtuales, ejecutar programas en emulador, y gestionar proyectos.

## 🛠️ Instalación

### Instalación en Producción

Para instalar CPCReady en tu sistema (se instalará en `~/.cpcready`):

```bash
# Clonar o descargar el proyecto
git clone https://github.com/CPCReady/toolchain.git
cd toolchain

# Ejecutar el instalador (desde la raíz del proyecto)
./install.sh
# O directamente desde la carpeta scripts:
# ./scripts/install.sh

# Recargar tu shell o ejecutar:
source ~/.zshrc  # para zsh
# o
source ~/.bashrc # para bash

# Verificar la instalación
cpc --help
```

### Desarrollo Local

Para trabajar en el desarrollo del proyecto:

```bash
# Clonar el proyecto
git clone https://github.com/CPCReady/toolchain.git
cd toolchain

# Configurar entorno de desarrollo (desde la raíz del proyecto)
./dev-setup.sh
# O directamente desde la carpeta scripts:
# ./scripts/dev-setup.sh

# El comando cpc estará disponible en este directorio
cpc --help
```

#### Uso con direnv (Recomendado para desarrollo)

Si tienes `direnv` instalado:

```bash
# Instalar direnv si no lo tienes
brew install direnv

# Agregar a tu shell (solo una vez)
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc  # para zsh
# o
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc # para bash

# Recargar tu shell
source ~/.zshrc  # o ~/.bashrc

# En el directorio del proyecto
direnv allow
# Automáticamente cargará las variables de entorno
```

## 🎯 Uso

### Comandos Disponibles

```bash
# Mostrar ayuda general
cpc --help

# Mostrar versión
cpc --version

# Listar todos los comandos
cpc commands

# Crear un disco virtual
cpc disc mydisk

# Guardar un archivo al disco
cpc save myfile.bas

# Ejecutar un programa
cpc run myprogram.bin

# Inicializar un nuevo proyecto
cpc init

# Mostrar información de versión detallada
cpc version
```

### Ejemplos de Uso

```bash
# Crear un nuevo proyecto
mkdir mi-proyecto-cpc
cd mi-proyecto-cpc
cpc init

# Crear un disco de trabajo
cpc disc trabajo

# Guardar un archivo BASIC
cpc save miprograma.bas

# Ejecutar el programa
cpc run miprograma.bas
```

## 📁 Estructura del Proyecto

```
├── bin/                    # Ejecutables principales
│   └── cpc                # Script principal
├── lib/                   # Librerías y módulos
│   ├── cpc-common.sh     # Funciones comunes
│   ├── cpc-commands.sh   # Lista de comandos
│   ├── cpc-disc.sh       # Gestión de discos
│   ├── cpc-run.sh        # Ejecución de programas
│   ├── cpc-save.sh       # Guardado de archivos
│   └── cpc-version.sh    # Información de versión
├── scripts/               # Scripts de desarrollo y distribución
│   ├── install.sh        # Script de instalación principal
│   ├── dev-setup.sh      # Configuración de desarrollo
│   └── commit.sh         # Utilidad para commits git
├── var/                   # Variables y datos
│   └── VERSION           # Versión actual
├── cfg/                   # Configuraciones
├── doc/                   # Documentación
├── install.sh            # Acceso directo a scripts/install.sh
├── dev-setup.sh          # Acceso directo a scripts/dev-setup.sh
├── .envrc                # Variables de entorno (direnv)
├── .dev                  # Configuración de desarrollo
└── README.md             # Este archivo
```

## 🔧 Configuración

### Variables de Entorno

- `CPCREADY_DIR`: Directorio base de CPCReady
- `CPCREADY_LIB`: Ruta a las librerías comunes
- `CPCREADY`: Tipo de entorno (`PROJECT` para desarrollo)

### Archivos de Configuración

- `.dev`: Indica modo desarrollo
- `.envrc`: Variables de entorno para direnv
- `.vscode/settings.json`: Configuración para VS Code

### Estructura Organizacional

El proyecto está organizado profesionalmente con separación de responsabilidades:

- **`bin/`**: Ejecutables principales del proyecto
- **`lib/`**: Librerías y módulos funcionales
- **`scripts/`**: Scripts de desarrollo, instalación y utilidades
- **`var/`**: Variables del sistema y configuración
- **`cfg/`**: Archivos de configuración
- **`doc/`**: Documentación del proyecto

Los scripts de acceso directo en la raíz (`install.sh`, `dev-setup.sh`) redirigen automáticamente a sus contrapartes en `scripts/` para mantener compatibilidad.

## 🚀 Desarrollo

### Estructura de Desarrollo

El proyecto está organizado para facilitar tanto el desarrollo como la distribución:

- **Modo Desarrollo**: Usa archivos locales del proyecto
- **Modo Producción**: Busca archivos en `~/.cpcready`

### Agregar Nuevos Comandos

1. Crear el script en `lib/cpc-<comando>.sh`
2. Agregar el comando al switch en `bin/cpc`
3. Actualizar la ayuda en `lib/cpc-common.sh`
4. Agregar a la lista en `lib/cpc-commands.sh`

### Testing

```bash
# En modo desarrollo
./dev-setup.sh  # o ./scripts/dev-setup.sh
cpc commands

# Probar instalación
./install.sh    # o ./scripts/install.sh
~/.local/bin/cpc --help

# Usar utilidades de desarrollo
./scripts/commit.sh "mensaje del commit"  # Commit rápido
```

### Scripts de Desarrollo

Los scripts de desarrollo están organizados en la carpeta `scripts/`:

- **`install.sh`**: Instalación completa del sistema
- **`dev-setup.sh`**: Configuración rápida para desarrollo
- **`commit.sh`**: Utilidad para commits git rápidos
- **`release.sh`**: 🆕 Utilidad para crear releases automáticos

Todos los scripts pueden ejecutarse tanto desde la raíz del proyecto (usando los accesos directos) como directamente desde la carpeta `scripts/`.

### 🏷️ Proceso de Release

El proyecto utiliza GitHub Actions para automatizar el proceso de release:

#### Método 1: Usando el script de release (Recomendado)

```bash
# Ver versión actual
./release.sh current

# Listar releases existentes
./release.sh list

# Crear nuevo release
./release.sh create 1.2.3
```

#### Método 2: Manual

```bash
# 1. Asegurarse de que todos los cambios están committed
git add .
git commit -m "Prepare for release v1.2.3"
git push

# 2. Crear y push del tag
git tag v1.2.3
git push origin v1.2.3
```

#### Lo que sucede automáticamente:

1. **GitHub Actions se activa** con el nuevo tag
2. **Actualiza `var/VERSION`** con la versión del tag (sin la 'v')
3. **Genera archivos de distribución**:
   - `cpcready-toolchain-1.2.3.zip` (Windows)
   - `cpcready-toolchain-1.2.3.tar.gz` (Linux/macOS)
4. **Crea el release en GitHub** con:
   - Notas de release automáticas
   - Instrucciones de instalación
   - Assets descargables
5. **Publica el release** públicamente

#### Formato de tags:

- ✅ `v1.0.0` - Release mayor
- ✅ `v1.2.3` - Release con patches
- ✅ `v2.0.0-beta.1` - Pre-release
- ✅ `v1.1.0-rc.2` - Release candidate

### 🔄 CI/CD Pipeline

- **`test.yml`**: Testing automático en cada push/PR
- **`release.yml`**: Generación automática de releases con tags

## 📋 Requisitos

- **Sistema Operativo**: macOS, Linux
- **Shell**: bash, zsh
- **Opcionales**:
  - `direnv` (recomendado para desarrollo)
  - Emuladores de CPC compatibles

## 🐛 Resolución de Problemas

### Error: "CPCReady not found"

```bash
# Verificar instalación
ls -la ~/.cpcready

# Reinstalar si es necesario
./install.sh
```

### Error: "command not found: cpc"

```bash
# Verificar PATH
echo $PATH | grep .local/bin

# Agregar al PATH si es necesario
export PATH="$HOME/.local/bin:$PATH"
```

### Problemas de Permisos en macOS

```bash
# Remover cuarentena si es necesario
xattr -d com.apple.quarantine ~/.local/bin/cpc
```

## 📄 Licencia

Este proyecto está licenciado bajo la GNU Lesser General Public License v3.0 - ver el archivo [LICENSE](LICENSE) para detalles.

## 🤝 Contribuir

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## 📞 Soporte

- **Documentación**: https://cpcready.readthedocs.io/
- **GitHub**: https://github.com/CPCReady
- **Issues**: https://github.com/CPCReady/toolchain/issues

---

© 2025 Destroyer - CPCReady Project