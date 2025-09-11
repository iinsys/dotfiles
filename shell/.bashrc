# DevOps Bash Configuration
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
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

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
# PROMPT CUSTOMIZATION
# =============================================================================

# Simple but informative prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Git branch in prompt (if git is available)
if command -v git &> /dev/null; then
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }
    export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
fi

# =============================================================================
# COMPLETION
# =============================================================================

# Enable programmable completion features
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Docker completion
if [ -f /usr/share/bash-completion/completions/docker ]; then
    . /usr/share/bash-completion/completions/docker
fi

# Kubernetes completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
fi

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

# Load local customizations if they exist
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# =============================================================================
# WELCOME MESSAGE
# =============================================================================

echo " DevOps Bash Configuration Loaded!"
echo " Try: gs, dps, kgp, tfp, dclean"
echo " Run 'alias' to see all available aliases"
