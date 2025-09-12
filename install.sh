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
    
    # Install tmux configuration
    if [ -f "$DOTFILES_DIR/tools/tmux/.tmux.conf" ]; then
        backup_file ~/.tmux.conf
        ln -sf "$DOTFILES_DIR/tools/tmux/.tmux.conf" ~/.tmux.conf
        print_success "Installed tmux configuration"
    fi
    
    # Install ctags configuration
    if [ -f "$DOTFILES_DIR/tools/ctags/.ctags" ]; then
        backup_file ~/.ctags
        ln -sf "$DOTFILES_DIR/tools/ctags/.ctags" ~/.ctags
        print_success "Installed ctags configuration"
    fi
}

# Install individual tool configurations
install_docker() {
    print_info "Installing Docker configurations..."
    if [ -d "$DOTFILES_DIR/tools/docker" ]; then
        mkdir -p ~/.docker
        cp -r "$DOTFILES_DIR/tools/docker/"* ~/.docker/ 2>/dev/null || true
        print_success "Installed Docker configurations"
    else
        print_warning "Docker configurations not found"
    fi
}

install_kubernetes() {
    print_info "Installing Kubernetes configurations..."
    if [ -d "$DOTFILES_DIR/tools/kubernetes" ]; then
        mkdir -p ~/.kube
        cp -r "$DOTFILES_DIR/tools/kubernetes/"* ~/.kube/ 2>/dev/null || true
        print_success "Installed Kubernetes configurations"
    else
        print_warning "Kubernetes configurations not found"
    fi
}

install_terraform() {
    print_info "Installing Terraform configurations..."
    if [ -d "$DOTFILES_DIR/tools/terraform" ]; then
        mkdir -p ~/.terraform.d
        cp -r "$DOTFILES_DIR/tools/terraform/"* ~/.terraform.d/ 2>/dev/null || true
        print_success "Installed Terraform configurations"
    else
        print_warning "Terraform configurations not found"
    fi
}

install_tmux() {
    print_info "Installing tmux configuration..."
    if [ -f "$DOTFILES_DIR/tools/tmux/.tmux.conf" ]; then
        backup_file ~/.tmux.conf
        ln -sf "$DOTFILES_DIR/tools/tmux/.tmux.conf" ~/.tmux.conf
        print_success "Installed tmux configuration"
    else
        print_warning "tmux configuration not found"
    fi
}

install_ctags() {
    print_info "Installing ctags configuration..."
    if [ -f "$DOTFILES_DIR/tools/ctags/.ctags" ]; then
        backup_file ~/.ctags
        ln -sf "$DOTFILES_DIR/tools/ctags/.ctags" ~/.ctags
        print_success "Installed ctags configuration"
    else
        print_warning "ctags configuration not found"
    fi
}

# Install individual shell configurations
install_bash() {
    print_info "Installing Bash configuration..."
    if [ -f "$DOTFILES_DIR/shell/.bashrc" ]; then
        backup_file ~/.bashrc
        cp "$DOTFILES_DIR/shell/.bashrc" ~/.bashrc
        print_success "Installed .bashrc"
    else
        print_warning "Bash configuration not found"
    fi
}

install_zsh() {
    print_info "Installing Zsh configuration..."
    if [ -f "$DOTFILES_DIR/shell/.zshrc" ]; then
        backup_file ~/.zshrc
        cp "$DOTFILES_DIR/shell/.zshrc" ~/.zshrc
        print_success "Installed .zshrc"
    else
        print_warning "Zsh configuration not found"
    fi
}

install_profile() {
    print_info "Installing profile configuration..."
    if [ -f "$DOTFILES_DIR/shell/.profile" ]; then
        backup_file ~/.profile
        cp "$DOTFILES_DIR/shell/.profile" ~/.profile
        print_success "Installed .profile"
    else
        print_warning "Profile configuration not found"
    fi
}

# Install individual editor configurations
install_vim() {
    print_info "Installing Vim configuration..."
    mkdir -p ~/.vim/{backup,swap,undo}
    if [ -f "$DOTFILES_DIR/editors/.vimrc" ]; then
        backup_file ~/.vimrc
        cp "$DOTFILES_DIR/editors/.vimrc" ~/.vimrc
        print_success "Installed .vimrc"
    else
        print_warning "Vim configuration not found"
    fi
}

install_nano() {
    print_info "Installing Nano configuration..."
    if [ -f "$DOTFILES_DIR/editors/.nanorc" ]; then
        backup_file ~/.nanorc
        cp "$DOTFILES_DIR/editors/.nanorc" ~/.nanorc
        print_success "Installed .nanorc"
    else
        print_warning "Nano configuration not found"
    fi
}

install_vscode() {
    print_info "Installing VS Code configuration..."
    if [ -d "$DOTFILES_DIR/editors/vscode" ]; then
        backup_file ~/.vscode
        mkdir -p ~/.vscode
        cp -r "$DOTFILES_DIR/editors/vscode/"* ~/.vscode/
        print_success "Installed VS Code settings"
    else
        print_warning "VS Code configuration not found"
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

# Interactive component selection
interactive_selection() {
    local components=()
    
    echo -e "${CYAN}Interactive Component Selection${NC}"
    echo -e "${CYAN}==============================${NC}"
    echo
    echo "Select which components to install:"
    echo
    
    # Main categories
    echo -e "${YELLOW}Main Categories:${NC}"
    echo
    read -p "Install all shell configurations? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("shell")
    fi
    
    read -p "Install all editor configurations? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("editors")
    fi
    
    read -p "Install Git configurations? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("git")
    fi
    
    read -p "Install all DevOps tools configurations? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("tools")
    fi
    
    echo
    echo -e "${YELLOW}Individual Components:${NC}"
    echo "If you selected main categories above, you can also add individual components:"
    echo
    
    # Individual shell components
    read -p "Install Bash configuration only? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("bash")
    fi
    
    read -p "Install Zsh configuration only? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("zsh")
    fi
    
    # Individual editor components
    read -p "Install Vim configuration only? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("vim")
    fi
    
    read -p "Install VS Code configuration only? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("vscode")
    fi
    
    # Individual tool components
    read -p "Install Docker configurations only? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("docker")
    fi
    
    read -p "Install tmux configuration only? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        components+=("tmux")
    fi
    
    echo
    if [ ${#components[@]} -eq 0 ]; then
        print_warning "No components selected. Installing everything..."
        components=("all")
    else
        print_info "Selected components: ${components[*]}"
    fi
    
    # Return components as space-separated string
    printf '%s ' "${components[@]}"
}

# Show help
show_help() {
    echo -e "${BLUE}DevOps Dotfiles Installation Script${NC}"
    echo -e "${BLUE}====================================${NC}"
    echo
    echo "Usage: $0 [OPTIONS] [COMPONENTS...]"
    echo
    echo "OPTIONS:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --version  Show version information"
    echo "  -i, --interactive  Interactive component selection"
    echo
    echo "COMPONENTS:"
    echo "  all            Install all configurations (default)"
    echo
    echo "  Main Categories:"
    echo "    shell        Install all shell configurations"
    echo "    editors      Install all editor configurations"
    echo "    git          Install Git configurations"
    echo "    tools        Install all DevOps tools configurations"
    echo
    echo "  Individual Shell Components:"
    echo "    bash         Install Bash configuration only"
    echo "    zsh          Install Zsh configuration only"
    echo "    profile      Install profile configuration only"
    echo
    echo "  Individual Editor Components:"
    echo "    vim          Install Vim configuration only"
    echo "    nano         Install Nano configuration only"
    echo "    vscode       Install VS Code configuration only"
    echo
    echo "  Individual Tool Components:"
    echo "    docker       Install Docker configurations only"
    echo "    kubernetes   Install Kubernetes configurations only"
    echo "    terraform    Install Terraform configurations only"
    echo "    tmux         Install tmux configuration only"
    echo "    ctags        Install ctags configuration only"
    echo
    echo "EXAMPLES:"
    echo "  $0                    # Install everything"
    echo "  $0 -i                 # Interactive selection menu"
    echo "  $0 shell              # Install all shell configurations"
    echo "  $0 vim tmux           # Install only Vim and tmux"
    echo "  $0 bash docker        # Install only Bash and Docker"
    echo "  $0 tools              # Install all DevOps tools"
    echo
}

# Show version
show_version() {
    echo "DevOps Dotfiles Installation Script v1.0.0"
    echo "Cross-platform installation for Linux, macOS, and Windows (WSL)"
}

# Main installation function
main() {
    local components=()
    local install_all=true
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--version)
                show_version
                exit 0
                ;;
            -i|--interactive)
                local selected_components=($(interactive_selection))
                components=("${selected_components[@]}")
                install_all=false
                shift
                ;;
            all)
                install_all=true
                shift
                ;;
            shell|editors|git|tools|bash|zsh|profile|vim|nano|vscode|docker|kubernetes|terraform|tmux|ctags)
                install_all=false
                components+=("$1")
                shift
                ;;
            *)
                print_error "Unknown component: $1"
                echo "Run '$0 --help' for available options"
                exit 1
                ;;
        esac
    done
    
    print_header
    
    # Check prerequisites
    if ! check_prerequisites; then
        print_error "Prerequisites check failed. Please install required tools."
        exit 1
    fi
    
    # Create backup directory
    create_backup
    
    # Install configurations based on arguments
    if [ "$install_all" = true ] || [ ${#components[@]} -eq 0 ]; then
        print_info "Installing all configurations..."
        install_shell
        install_editors
        install_git
        install_tools
        install_completions
    else
        print_info "Installing selected components: ${components[*]}"
        
        for component in "${components[@]}"; do
            case $component in
                shell)
                    install_shell
                    ;;
                editors)
                    install_editors
                    ;;
                git)
                    install_git
                    ;;
                tools)
                    install_tools
                    ;;
                bash)
                    install_bash
                    ;;
                zsh)
                    install_zsh
                    ;;
                profile)
                    install_profile
                    ;;
                vim)
                    install_vim
                    ;;
                nano)
                    install_nano
                    ;;
                vscode)
                    install_vscode
                    ;;
                docker)
                    install_docker
                    ;;
                kubernetes)
                    install_kubernetes
                    ;;
                terraform)
                    install_terraform
                    ;;
                tmux)
                    install_tmux
                    ;;
                ctags)
                    install_ctags
                    ;;
            esac
        done
        
        # Install completions if shell or tools are installed
        if [[ " ${components[*]} " =~ " shell " ]] || [[ " ${components[*]} " =~ " tools " ]] || [[ " ${components[*]} " =~ " bash " ]] || [[ " ${components[*]} " =~ " zsh " ]]; then
            install_completions
        fi
    fi
    
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
    echo
    echo -e "${YELLOW}Git Aliases:${NC}"
    echo "  gs   - git status (show repository status)"
    echo "  ga   - git add (stage files)"
    echo "  gc   - git commit (commit changes)"
    echo "  gp   - git push (push to remote)"
    echo "  gl   - git log --oneline (show commit history)"
    echo "  gd   - git diff (show changes)"
    echo "  gb   - git branch (list branches)"
    echo "  gco  - git checkout (switch branches)"
    echo "  gpl  - git pull (pull from remote)"
    echo
    echo -e "${YELLOW}Docker Aliases:${NC}"
    echo "  d    - docker (docker command)"
    echo "  dc   - docker-compose (docker-compose command)"
    echo "  dps  - docker ps (list running containers)"
    echo "  dpsa - docker ps -a (list all containers)"
    echo "  di   - docker images (list images)"
    echo "  dex  - docker exec -it (execute in container)"
    echo "  dlog - docker logs (show container logs)"
    echo
    echo -e "${YELLOW}Kubernetes Aliases:${NC}"
    echo "  k    - kubectl (kubectl command)"
    echo "  kgp  - kubectl get pods (list pods)"
    echo "  kgs  - kubectl get services (list services)"
    echo "  kgd  - kubectl get deployments (list deployments)"
    echo "  kgn  - kubectl get nodes (list nodes)"
    echo "  klog - kubectl logs (show pod logs)"
    echo
    echo -e "${YELLOW}Terraform Aliases:${NC}"
    echo "  tf   - terraform (terraform command)"
    echo "  tfi  - terraform init (initialize terraform)"
    echo "  tfp  - terraform plan (plan changes)"
    echo "  tfa  - terraform apply (apply changes)"
    echo "  tfd  - terraform destroy (destroy infrastructure)"
    echo
    print_info "Run 'alias' to see all available aliases"
    echo
}

# Run main function
main "$@"
