# DevOps Tools Configurations

This directory contains configuration files for common DevOps tools.

## Directory Structure

```
tools/
├── docker/                 # Docker configurations
│   └── docker-compose.yml  # Development environment template
├── kubernetes/             # Kubernetes configurations
│   └── kubectl-config      # kubectl config template
├── terraform/              # Terraform configurations
│   └── terraform.tfvars.example  # Variables template
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
