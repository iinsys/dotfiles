#!/bin/bash

# DevOps Dotfiles Installation Script
# Cross-platform installation script for Linux, macOS, and Windows (WSL)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS_DISTRO="$ID"
            OS_VERSION="$VERSION_ID"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        OS_DISTRO="macos"
        OS_VERSION=$(sw_vers -productVersion)
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        OS="windows"
        OS_DISTRO="windows"
        OS_VERSION=$(cmd //c ver 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1)
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        OS="freebsd"
        OS_DISTRO="freebsd"
        OS_VERSION=$(freebsd-version)
    else
        OS="unknown"
        OS_DISTRO="unknown"
        OS_VERSION="unknown"
    fi
}

# Initialize OS detection
detect_os

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  DevOps Dotfiles Installation  ${NC}"
    echo -e "${BLUE}================================${NC}"
    echo -e "${CYAN}OS: $OS ($OS_DISTRO $OS_VERSION)${NC}"
    echo -e "${CYAN}Shell: $SHELL${NC}"
    echo -e "${CYAN}User: $USER${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Create backup directory
create_backup() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        print_info "Created backup directory: $BACKUP_DIR"
    fi
}

# Backup existing file
backup_file() {
    local file="$1"
    if [ -f "$file" ] || [ -d "$file" ]; then
        local basename=$(basename "$file")
        cp -r "$file" "$BACKUP_DIR/$basename"
        print_info "Backed up $file to $BACKUP_DIR/$basename"
    fi
}

# Install shell configurations
install_shell() {
    print_info "Installing shell configurations..."
    
    # Create vim directories
    mkdir -p ~/.vim/{backup,swap,undo}
    
    # Install bashrc
    if [ -f "$DOTFILES_DIR/shell/.bashrc" ]; then
        backup_file ~/.bashrc
        cp "$DOTFILES_DIR/shell/.bashrc" ~/.bashrc
        print_success "Installed .bashrc"
    fi
    
    # Install zshrc
    if [ -f "$DOTFILES_DIR/shell/.zshrc" ]; then
        backup_file ~/.zshrc
        cp "$DOTFILES_DIR/shell/.zshrc" ~/.zshrc
        print_success "Installed .zshrc"
    fi
    
    # Install profile
    if [ -f "$DOTFILES_DIR/shell/.profile" ]; then
        backup_file ~/.profile
        cp "$DOTFILES_DIR/shell/.profile" ~/.profile
        print_success "Installed .profile"
    fi
}

# Install editor configurations
install_editors() {
    print_info "Installing editor configurations..."
    
    # Install vimrc
    if [ -f "$DOTFILES_DIR/editors/.vimrc" ]; then
        backup_file ~/.vimrc
        cp "$DOTFILES_DIR/editors/.vimrc" ~/.vimrc
        print_success "Installed .vimrc"
    fi
    
    # Install nanorc
    if [ -f "$DOTFILES_DIR/editors/.nanorc" ]; then
        backup_file ~/.nanorc
        cp "$DOTFILES_DIR/editors/.nanorc" ~/.nanorc
        print_success "Installed .nanorc"
    fi
    
    # Install VS Code settings
    if [ -d "$DOTFILES_DIR/editors/vscode" ]; then
        backup_file ~/.vscode
        mkdir -p ~/.vscode
        cp -r "$DOTFILES_DIR/editors/vscode/"* ~/.vscode/
        print_success "Installed VS Code settings"
    fi
}

# Install Git configurations
install_git() {
    print_info "Installing Git configurations..."
    
    # Install gitconfig
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        backup_file ~/.gitconfig
        cp "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
        print_success "Installed .gitconfig"
    fi
    
    # Install global gitignore
    if [ -f "$DOTFILES_DIR/git/.gitignore_global" ]; then
        backup_file ~/.gitignore_global
        cp "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
        git config --global core.excludesfile ~/.gitignore_global
        print_success "Installed .gitignore_global"
    fi
}

# Install DevOps tools configurations
install_tools() {
    print_info "Installing DevOps tools configurations..."
    
    # Install Docker configurations
    if [ -d "$DOTFILES_DIR/tools/docker" ]; then
        mkdir -p ~/.docker
        cp -r "$DOTFILES_DIR/tools/docker/"* ~/.docker/ 2>/dev/null || true
        print_success "Installed Docker configurations"
    fi
    
    # Install Kubernetes configurations
    if [ -d "$DOTFILES_DIR/tools/kubernetes" ]; then
        mkdir -p ~/.kube
        cp -r "$DOTFILES_DIR/tools/kubernetes/"* ~/.kube/ 2>/dev/null || true
        print_success "Installed Kubernetes configurations"
    fi
    
    # Install Terraform configurations
    if [ -d "$DOTFILES_DIR/tools/terraform" ]; then
        mkdir -p ~/.terraform.d
        cp -r "$DOTFILES_DIR/tools/terraform/"* ~/.terraform.d/ 2>/dev/null || true
        print_success "Installed Terraform configurations"
    fi
}

# Check prerequisites
check_prerequisites() {
    print_info "Checking prerequisites..."
    
    # Check if Git is installed
    if ! command_exists git; then
        print_warning "Git is not installed. Please install Git first."
        print_info "Installation instructions:"
        case $OS in
            "linux")
                case $OS_DISTRO in
                    "ubuntu"|"debian")
                        echo "  sudo apt update && sudo apt install git"
                        ;;
                    "centos"|"rhel"|"fedora")
                        echo "  sudo yum install git (CentOS/RHEL) or sudo dnf install git (Fedora)"
                        ;;
                    "arch")
                        echo "  sudo pacman -S git"
                        ;;
                    *)
                        echo "  Use your package manager to install git"
                        ;;
                esac
                ;;
            "macos")
                echo "  brew install git (if using Homebrew)"
                echo "  Or download from: https://git-scm.com/download/mac"
                ;;
            "windows")
                echo "  Download from: https://git-scm.com/download/win"
                echo "  Or use: winget install Git.Git"
                ;;
        esac
        return 1
    fi
    
    # Check shell compatibility
    if [[ "$SHELL" == *"bash"* ]] || [[ "$SHELL" == *"zsh"* ]]; then
        print_success "Shell compatibility: $SHELL"
    else
        print_warning "Shell $SHELL may not be fully supported. Bash or Zsh recommended."
    fi
    
    # Check if we're in a Git repository
    if [ ! -d ".git" ]; then
        print_warning "Not in a Git repository. Some features may not work correctly."
    fi
    
    print_success "Prerequisites check completed"
}

# Set up user configuration
setup_user_config() {
    print_info "Setting up user configuration..."
    
    # Check if user name and email are set
    if ! git config --global user.name >/dev/null 2>&1; then
        print_warning "Git user.name is not set. Please set it with:"
        echo "  git config --global user.name 'Your Name'"
    fi
    
    if ! git config --global user.email >/dev/null 2>&1; then
        print_warning "Git user.email is not set. Please set it with:"
        echo "  git config --global user.email 'your.email@example.com'"
    fi
    
    print_success "User configuration setup completed"
}

# Install completion scripts
install_completions() {
    print_info "Installing completion scripts..."
    
    # Install kubectl completion if available
    if command_exists kubectl; then
        if [ -f ~/.bashrc ]; then
            if ! grep -q "kubectl completion bash" ~/.bashrc; then
                echo 'source <(kubectl completion bash)' >> ~/.bashrc
                print_success "Added kubectl completion to .bashrc"
            fi
        fi
        
        if [ -f ~/.zshrc ]; then
            if ! grep -q "kubectl completion zsh" ~/.zshrc; then
                echo 'source <(kubectl completion zsh)' >> ~/.zshrc
                print_success "Added kubectl completion to .zshrc"
            fi
        fi
    fi
    
    # Install Docker completion if available
    if command_exists docker; then
        if [ -f /usr/share/bash-completion/completions/docker ]; then
            if [ -f ~/.bashrc ]; then
                if ! grep -q "docker completion" ~/.bashrc; then
                    echo 'source /usr/share/bash-completion/completions/docker' >> ~/.bashrc
                    print_success "Added Docker completion to .bashrc"
                fi
            fi
        fi
    fi
}

# Main installation function
main() {
    print_header
    
    # Check prerequisites
    if ! check_prerequisites; then
        print_error "Prerequisites check failed. Please install required tools."
        exit 1
    fi
    
    # Create backup directory
    create_backup
    
    # Install configurations
    install_shell
    install_editors
    install_git
    install_tools
    install_completions
    
    # Set up user configuration
    setup_user_config
    
    echo
    print_success "Installation completed successfully!"
    echo
    print_info "Next steps:"
    echo "  1. Restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
    echo "  2. Set your Git user name and email if not already set"
    echo "  3. Customize configurations in ~/.bashrc.local, ~/.zshrc.local, etc."
    echo
    print_info "Backup created at: $BACKUP_DIR"
    echo
    print_info "Available aliases:"
    echo "  Git: gs, ga, gc, gp, gl, gd, gb, gco, gpl"
    echo "  Docker: d, dc, dps, dpsa, di, dex, dlog"
    echo "  Kubernetes: k, kgp, kgs, kgd, kgn, klog"
    echo "  Terraform: tf, tfi, tfp, tfa, tfd"
    echo
    print_info "Run 'alias' to see all available aliases"
    echo
}

# Run main function
main "$@"
