#!/bin/bash

# Actualizar el sistema
apt-get update
apt-get upgrade -y

# Instalar dependencias necesarias
apt-get install -y build-essential curl file git

# Instalar Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Agregar Homebrew al PATH
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/vscode/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Verificar la instalación
brew doctor

# Instalar paquetes base de brew
brew install gcc cmake zsh-autosuggestions

# Instalar oh-my-zsh
su - vscode -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# Configurar zsh
cat >> /home/vscode/.zshrc << 'EOL'
# Tema con soporte git
ZSH_THEME="agnoster"

# Plugins
plugins=(git zsh-autosuggestions)

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
EOL

# Configurar bash git prompt
cat >> /home/vscode/.bashrc << 'EOL'
# Git prompt configuration
if [ -f "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh" ]; then
    source "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi
EOL

# Instalar completado de git para bash
brew install bash-completion

# Dar permisos al usuario vscode
chown -R vscode:vscode /home/linuxbrew/
chown vscode:vscode /home/vscode/.zshrc
chown vscode:vscode /home/vscode/.bashrc

# Mensaje de finalización
echo "Configuración completada. Homebrew está instalado y listo para usar."