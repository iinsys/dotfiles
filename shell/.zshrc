# DevOps Zsh Configuration
# This file contains practical aliases, functions, and settings for DevOps work

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# Set default editor
export EDITOR=vim
export VISUAL=vim

# Add common paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# History settings
export HISTSIZE=10000
export HISTFILESIZE=20000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# =============================================================================
# ALIASES
# =============================================================================

# System aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gpl='git pull'
alias gst='git stash'
alias gstp='git stash pop'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs'
alias dstop='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias klog='kubectl logs'
alias kex='kubectl exec -it'

# AWS CLI aliases
alias aws-profile='aws configure list-profiles'
alias aws-region='aws configure get region'

# Terraform aliases
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfo='terraform output'
alias tfs='terraform show'

# Network and system aliases
alias ports='netstat -tuln'
alias myip='curl -s ifconfig.me'
alias weather='curl -s wttr.in'
alias ping='ping -c 5'

# File operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# =============================================================================
# FUNCTIONS
# =============================================================================

# Docker functions
dclean() {
    echo "Cleaning up Docker resources..."
    docker system prune -f
    docker volume prune -f
    echo "Docker cleanup complete!"
}

dstopall() {
    echo "Stopping all running containers..."
    docker stop $(docker ps -q)
}

# Git functions
gac() {
    git add . && git commit -m "$1"
}

gacp() {
    git add . && git commit -m "$1" && git push
}

# Kubernetes functions
kns() {
    kubectl config set-context --current --namespace="$1"
}

kctx() {
    kubectl config use-context "$1"
}

# AWS functions
aws-profile-set() {
    export AWS_PROFILE="$1"
    echo "AWS Profile set to: $1"
}

# Terraform functions
tfiup() {
    terraform init -upgrade
}

# System functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find files
ff() {
    find . -type f -name "*$1*"
}

# Find directories
fd() {
    find . -type d -name "*$1*"
}

# Quick server
serve() {
    local port=${1:-8000}
    echo "Serving on http://localhost:$port"
    python3 -m http.server "$port"
}

# =============================================================================
# ZSH OPTIONS
# =============================================================================

# Enable colors
autoload -U colors && colors

# Auto-completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Auto-correction
setopt CORRECT
setopt CORRECT_ALL

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# =============================================================================
# PROMPT CUSTOMIZATION
# =============================================================================

# Simple but informative prompt with git branch
autoload -U vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST

# Color-coded prompt
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f $ '

# =============================================================================
# PLUGINS (Optional - requires oh-my-zsh or similar)
# =============================================================================

# Uncomment if you have oh-my-zsh installed
# export ZSH="$HOME/.oh-my-zsh"
# plugins=(git docker kubectl aws terraform)
# source $ZSH/oh-my-zsh.sh

# =============================================================================
# COMPLETION
# =============================================================================

# Docker completion
if [ -f /usr/share/zsh/site-functions/_docker ]; then
    . /usr/share/zsh/site-functions/_docker
fi

# Kubernetes completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

# AWS CLI completion
if command -v aws &> /dev/null; then
    complete -C aws_completer aws
fi

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

# Load local customizations if they exist
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# =============================================================================
# WELCOME MESSAGE
# =============================================================================

echo " DevOps Zsh Configuration Loaded!"
echo " Try: gs, dps, kgp, tfp, dclean"
echo " Run 'alias' to see all available aliases"
