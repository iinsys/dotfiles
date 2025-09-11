#!/bin/bash

# Terraform Aliases and Functions for DevOps
# Source this file in your shell configuration

# =============================================================================
# TERRAFORM ALIASES
# =============================================================================

# Basic Terraform commands
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfo='terraform output'
alias tfs='terraform show'
alias tft='terraform taint'
alias tfu='terraform untaint'
alias tfg='terraform get'
alias tfr='terraform refresh'
alias tfiup='terraform init -upgrade'
alias tfv='terraform validate'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'

# Terraform workspace commands
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tfwn='terraform workspace new'
alias tfwd='terraform workspace delete'
alias tfwc='terraform workspace show'

# Terraform state commands
alias tfsl='terraform state list'
alias tfss='terraform state show'
alias tfsr='terraform state rm'
alias tfsp='terraform state pull'
alias tfsm='terraform state mv'
alias tfsi='terraform state import'

# Terraform import commands
alias tfi='terraform import'
alias tfip='terraform import -var-file=production.tfvars'
alias tfid='terraform import -var-file=development.tfvars'

# Terraform plan and apply with variables
alias tfpv='terraform plan -var-file='
alias tfav='terraform apply -var-file='
alias tfdv='terraform destroy -var-file='

# Terraform plan and apply with auto-approve
alias tfpa='terraform plan -auto-approve'
alias tfaa='terraform apply -auto-approve'
alias tfda='terraform destroy -auto-approve'

# Terraform with specific targets
alias tfpt='terraform plan -target='
alias tfat='terraform apply -target='
alias tfdt='terraform destroy -target='

# Terraform with parallelism
alias tfpp='terraform plan -parallelism='
alias tfap='terraform apply -parallelism='
alias tfdp='terraform destroy -parallelism='

# Terraform with refresh
alias tfpr='terraform plan -refresh=true'
alias tfpnr='terraform plan -refresh=false'
alias tfar='terraform apply -refresh=true'
alias tfanr='terraform apply -refresh=false'

# Terraform with detailed logging
alias tfpd='TF_LOG=DEBUG terraform plan'
alias tfad='TF_LOG=DEBUG terraform apply'
alias tfdd='TF_LOG=DEBUG terraform destroy'

# Terraform with specific log levels
alias tfptrace='TF_LOG=TRACE terraform plan'
alias tfatrace='TF_LOG=TRACE terraform apply'
alias tfdtrace='TF_LOG=TRACE terraform destroy'

# =============================================================================
# TERRAFORM FUNCTIONS
# =============================================================================

# Initialize Terraform with upgrade
tfiup() {
    echo "Initializing Terraform with upgrade..."
    terraform init -upgrade
}

# Plan with specific environment
tfplan() {
    local env=${1:-dev}
    local var_file="terraform.tfvars"
    
    if [ -f "${env}.tfvars" ]; then
        var_file="${env}.tfvars"
    fi
    
    echo "Planning Terraform for environment: $env"
    terraform plan -var-file="$var_file"
}

# Apply with specific environment
tfapply() {
    local env=${1:-dev}
    local var_file="terraform.tfvars"
    
    if [ -f "${env}.tfvars" ]; then
        var_file="${env}.tfvars"
    fi
    
    echo " Applying Terraform for environment: $env"
    terraform apply -var-file="$var_file"
}

# Destroy with specific environment
tfdestroy() {
    local env=${1:-dev}
    local var_file="terraform.tfvars"
    
    if [ -f "${env}.tfvars" ]; then
        var_file="${env}.tfvars"
    fi
    
    echo " Destroying Terraform for environment: $env"
    terraform destroy -var-file="$var_file"
}

# Format all Terraform files
tfformat() {
    echo " Formatting Terraform files..."
    terraform fmt -recursive
    echo " Formatting complete!"
}

# Validate Terraform configuration
tfvalidate() {
    echo " Validating Terraform configuration..."
    terraform validate
    if [ $? -eq 0 ]; then
        echo " Validation passed!"
    else
        echo " Validation failed!"
        return 1
    fi
}

# Show Terraform plan in a readable format
tfplanreadable() {
    echo " Terraform plan (readable format):"
    terraform plan -detailed-exitcode
}

# Get Terraform output as JSON
tfoutput() {
    local output=${1:-}
    if [ -n "$output" ]; then
        terraform output -json "$output" | jq -r '.'
    else
        terraform output -json | jq '.'
    fi
}

# List all Terraform resources
tfresources() {
    echo " Terraform resources:"
    terraform state list
}

# Show specific resource
tfresource() {
    local resource=${1:-}
    if [ -z "$resource" ]; then
        echo "Usage: tfresource <resource_name>"
        return 1
    fi
    
    echo " Resource details for $resource:"
    terraform state show "$resource"
}

# Import resource
tfimport() {
    local resource=${1:-}
    local id=${2:-}
    
    if [ -z "$resource" ] || [ -z "$id" ]; then
        echo "Usage: tfimport <resource_name> <resource_id>"
        return 1
    fi
    
    echo "📥 Importing resource $resource with ID $id..."
    terraform import "$resource" "$id"
}

# Remove resource from state
tfremove() {
    local resource=${1:-}
    if [ -z "$resource" ]; then
        echo "Usage: tfremove <resource_name>"
        return 1
    fi
    
    echo " Removing resource $resource from state..."
    terraform state rm "$resource"
}

# Move resource in state
tfmove() {
    local from=${1:-}
    local to=${2:-}
    
    if [ -z "$from" ] || [ -z "$to" ]; then
        echo "Usage: tfmove <from_resource> <to_resource>"
        return 1
    fi
    
    echo " Moving resource from $from to $to..."
    terraform state mv "$from" "$to"
}

# Terraform workspace management
tfworkspace() {
    local action=${1:-list}
    local name=${2:-}
    
    case $action in
        "list"|"ls")
            echo "📁 Available workspaces:"
            terraform workspace list
            ;;
        "select"|"use")
            if [ -z "$name" ]; then
                echo "Usage: tfworkspace select <workspace_name>"
                return 1
            fi
            echo " Switching to workspace: $name"
            terraform workspace select "$name"
            ;;
        "new"|"create")
            if [ -z "$name" ]; then
                echo "Usage: tfworkspace new <workspace_name>"
                return 1
            fi
            echo "🆕 Creating new workspace: $name"
            terraform workspace new "$name"
            ;;
        "delete"|"remove")
            if [ -z "$name" ]; then
                echo "Usage: tfworkspace delete <workspace_name>"
                return 1
            fi
            echo " Deleting workspace: $name"
            terraform workspace delete "$name"
            ;;
        "current"|"show")
            echo "📍 Current workspace:"
            terraform workspace show
            ;;
        *)
            echo "Usage: tfworkspace [list|select|new|delete|current] [name]"
            ;;
    esac
}

# Terraform with specific target
tftarget() {
    local target=${1:-}
    local action=${2:-plan}
    
    if [ -z "$target" ]; then
        echo "Usage: tftarget <resource_name> [plan|apply|destroy]"
        return 1
    fi
    
    case $action in
        "plan")
            echo " Planning with target: $target"
            terraform plan -target="$target"
            ;;
        "apply")
            echo " Applying with target: $target"
            terraform apply -target="$target"
            ;;
        "destroy")
            echo " Destroying with target: $target"
            terraform destroy -target="$target"
            ;;
        *)
            echo "Usage: tftarget <resource_name> [plan|apply|destroy]"
            ;;
    esac
}

# Terraform with parallelism
tfparallel() {
    local count=${1:-10}
    local action=${2:-plan}
    
    case $action in
        "plan")
            echo " Planning with parallelism: $count"
            terraform plan -parallelism="$count"
            ;;
        "apply")
            echo " Applying with parallelism: $count"
            terraform apply -parallelism="$count"
            ;;
        "destroy")
            echo " Destroying with parallelism: $count"
            terraform destroy -parallelism="$count"
            ;;
        *)
            echo "Usage: tfparallel <count> [plan|apply|destroy]"
            ;;
    esac
}

# Terraform with refresh control
tfrefresh() {
    local refresh=${1:-true}
    local action=${2:-plan}
    
    case $action in
        "plan")
            echo " Planning with refresh: $refresh"
            terraform plan -refresh="$refresh"
            ;;
        "apply")
            echo " Applying with refresh: $refresh"
            terraform apply -refresh="$refresh"
            ;;
        *)
            echo "Usage: tfrefresh [true|false] [plan|apply]"
            ;;
    esac
}

# Terraform with logging
tflog() {
    local level=${1:-DEBUG}
    local action=${2:-plan}
    
    case $action in
        "plan")
            echo " Planning with log level: $level"
            TF_LOG="$level" terraform plan
            ;;
        "apply")
            echo " Applying with log level: $level"
            TF_LOG="$level" terraform apply
            ;;
        "destroy")
            echo " Destroying with log level: $level"
            TF_LOG="$level" terraform destroy
            ;;
        *)
            echo "Usage: tflog [TRACE|DEBUG|INFO|WARN|ERROR] [plan|apply|destroy]"
            ;;
    esac
}

# Terraform security scan
tfsecurity() {
    echo " Running Terraform security scan..."
    if command -v tfsec &> /dev/null; then
        tfsec .
    elif command -v checkov &> /dev/null; then
        checkov -d . --framework terraform
    else
        echo "⚠️ Security tools not found. Install tfsec or checkov."
        echo "  tfsec: https://github.com/aquasecurity/tfsec"
        echo "  checkov: https://github.com/bridgecrewio/checkov"
    fi
}

# Terraform cost estimation
tfcost() {
    echo "💰 Estimating Terraform costs..."
    if command -v infracost &> /dev/null; then
        infracost breakdown --path .
    else
        echo "⚠️ Infracost not found. Install it from: https://www.infracost.io/"
    fi
}

# Terraform graph
tfgraph() {
    echo " Generating Terraform graph..."
    terraform graph | dot -Tpng > terraform-graph.png
    echo " Graph saved as terraform-graph.png"
}

# Terraform cleanup
tfclean() {
    echo "🧹 Cleaning up Terraform files..."
    rm -f .terraform.lock.hcl
    rm -rf .terraform/
    rm -f terraform.tfstate.backup
    rm -f *.tfplan
    echo " Cleanup complete!"
}

# Terraform backup
tfbackup() {
    local backup_dir=${1:-./terraform-backup}
    local timestamp=$(date +%Y%m%d-%H%M%S)
    
    echo "💾 Creating Terraform backup in $backup_dir..."
    mkdir -p "$backup_dir"
    
    # Backup state files
    if [ -f "terraform.tfstate" ]; then
        cp terraform.tfstate "$backup_dir/terraform.tfstate_$timestamp"
    fi
    
    # Backup plan files
    find . -name "*.tfplan" -exec cp {} "$backup_dir/" \;
    
    # Backup variable files
    find . -name "*.tfvars" -exec cp {} "$backup_dir/" \;
    
    echo " Backup completed in $backup_dir"
}

# Terraform health check
tfhealth() {
    echo " Terraform health check:"
    echo "Terraform version: $(terraform --version)"
    echo
    echo "Current workspace: $(terraform workspace show)"
    echo
    echo "Configuration validation:"
    terraform validate
    echo
    echo "Format check:"
    terraform fmt -check -recursive
    echo
    echo "State status:"
    terraform state list | wc -l | xargs echo "Resources in state:"
}

echo " Terraform aliases and functions loaded!"
echo " Try: tfplan, tfapply, tfworkspace, tfsecurity, tfcost"
