# DevOps Tools Configurations

This directory contains configuration files for common DevOps tools.

## Directory Structure

```
tools/
├── docker/                 # Docker configurations
│   ├── docker-compose.yml  # Development environment template
│   ├── Dockerfile.template # Docker image template
│   ├── .dockerignore       # Docker ignore patterns
│   └── docker-aliases.sh   # Docker shell aliases
├── kubernetes/             # Kubernetes configurations
│   └── kubectl-config      # kubectl config template
├── terraform/              # Terraform configurations
│   ├── terraform.tfvars.example  # Variables template
│   └── terraform-aliases.sh      # Terraform shell aliases
├── tmux/                   # Terminal multiplexer
│   └── .tmux.conf          # tmux configuration
├── ctags/                  # Code navigation
│   └── .ctags              # ctags configuration
└── README.md               # This file
```

## Docker

### docker-compose.yml
A comprehensive Docker Compose template for development environments including:

- **PostgreSQL**: Development database
- **Redis**: Caching layer
- **MongoDB**: Document storage
- **Nginx**: Reverse proxy
- **Prometheus**: Monitoring
- **Grafana**: Visualization
- **ELK Stack**: Logging (Elasticsearch, Logstash, Kibana)

### Usage
```bash
# Start all services
docker-compose up -d

# Start specific services
docker-compose up -d postgres redis

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## Kubernetes

### kubectl-config
Template for kubectl configuration with multiple cluster contexts:

- **dev-cluster**: Development environment
- **staging-cluster**: Staging environment
- **prod-cluster**: Production environment

### Usage
```bash
# Copy template to kubeconfig
cp tools/kubernetes/kubectl-config ~/.kube/config

# Switch contexts
kubectl config use-context dev-context
kubectl config use-context staging-context
kubectl config use-context prod-context

# View current context
kubectl config current-context
```

## Terraform

### terraform.tfvars.example
Template for Terraform variables including:

- **AWS Configuration**: Region, profile
- **Environment**: Environment name, project
- **Networking**: VPC, subnets
- **EC2**: Instance type, AMI, key pair
- **Database**: RDS configuration
- **Tags**: Resource tagging

### Usage
```bash
# Copy template
cp tools/terraform/terraform.tfvars.example terraform.tfvars

# Edit variables
vim terraform.tfvars

# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply
```

## Installation

These configurations are automatically installed when you run the main installation script:

```bash
./install.sh
```

Or install manually:

```bash
# Docker
cp -r tools/docker/* ~/.docker/

# Kubernetes
cp tools/kubernetes/kubectl-config ~/.kube/config

# Terraform
cp tools/terraform/terraform.tfvars.example ~/.terraform.d/
```

## Customization

### Docker
- Modify `docker-compose.yml` for your specific services
- Add custom volumes and networks
- Adjust resource limits and environment variables

### Kubernetes
- Update cluster endpoints and certificates
- Add additional contexts and users
- Configure namespaces and RBAC

### Terraform
- Customize variables for your environment
- Add additional resource configurations
- Set up remote state backends

## tmux

### .tmux.conf
Advanced terminal multiplexer configuration with:

- **Prefix Key**: Ctrl-a (easier than default Ctrl-b)
- **Mouse Support**: Full mouse integration
- **Pane Navigation**: Alt-arrow keys for seamless navigation
- **Window Management**: Alt-number keys for quick window switching
- **Status Bar**: Customized with system information
- **Copy Mode**: Vi keybindings for efficient text selection
- **Plugin Support**: Ready for TPM (Tmux Plugin Manager)

### Key Bindings
- `Ctrl-a |` - Split pane horizontally
- `Ctrl-a -` - Split pane vertically
- `Alt-arrow` - Navigate between panes
- `Ctrl-arrow` - Resize panes
- `Alt-1-9` - Switch to window 1-9
- `Ctrl-a r` - Reload configuration

### Usage
```bash
# Start tmux session
tmux

# Start named session
tmux new-session -s devops

# Attach to existing session
tmux attach -t devops

# List sessions
tmux list-sessions
```

## ctags

### .ctags
Enhanced code navigation and indexing configuration supporting:

- **Languages**: Python, JavaScript/TypeScript, Go, Shell, Docker, Terraform, YAML, JSON
- **Advanced Patterns**: Function definitions, class declarations, variable assignments
- **Exclusions**: Common build directories and temporary files
- **Output Format**: Sorted with line numbers and file scope

### Supported Languages
- **Python**: Classes, functions, decorators
- **JavaScript/TypeScript**: Functions, classes, variables, constants
- **Go**: Functions, types, variables, constants
- **Shell**: Function definitions
- **Docker**: Images, labels, environment variables
- **Terraform**: Resources, data sources, variables, outputs, modules
- **YAML/JSON**: Key definitions

### Usage
```bash
# Generate tags for current directory
ctags -R .

# Generate tags for specific language
ctags -R --languages=Python .

# Use with Vim
vim -t function_name

# Jump to tag in Vim
Ctrl-]  # Jump to tag under cursor
Ctrl-t  # Return from tag
```

## Security Notes

- **Never commit sensitive data** like passwords, API keys, or certificates
- Use environment variables or secret management systems
- Rotate credentials regularly
- Follow least privilege principles

## Contributing

When adding new tool configurations:
1. Keep them practical and commonly used
2. Include clear documentation
3. Provide usage examples
4. Consider security implications
5. Test on multiple platforms
