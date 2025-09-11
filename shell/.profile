# DevOps Profile Configuration
# Common environment variables and settings for all shells

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# Set default editor
export EDITOR=vim
export VISUAL=vim

# Add common paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# =============================================================================
# DEVELOPMENT TOOLS
# =============================================================================

# Node.js (if installed)
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Python (if using pyenv)
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Go (if installed)
if [ -d "/usr/local/go" ]; then
    export PATH="/usr/local/go/bin:$PATH"
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

# Rust (if installed)
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# =============================================================================
# DEVOPS TOOLS
# =============================================================================

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Kubernetes
export KUBECONFIG="$HOME/.kube/config"

# Terraform
export TF_CLI_ARGS_plan="-parallelism=10"
export TF_CLI_ARGS_apply="-parallelism=10"

# AWS
export AWS_PAGER=""

# =============================================================================
# SECURITY
# =============================================================================

# Disable history for sensitive commands
export HISTCONTROL=ignoreboth:erasedups

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

# Load local customizations if they exist
if [ -f ~/.profile.local ]; then
    source ~/.profile.local
fi
