#!/bin/bash

# Docker Aliases and Functions for DevOps
# Source this file in your shell configuration

# =============================================================================
# DOCKER ALIASES
# =============================================================================

# Basic Docker commands
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs'
alias dcf='docker-compose logs -f'

# Container management
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpsq='docker ps -q'
alias dpsaq='docker ps -aq'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drma='docker rm $(docker ps -aq)'
alias drmaf='docker rm -f $(docker ps -aq)'

# Image management
alias di='docker images'
alias diq='docker images -q'
alias drmi='docker rmi'
alias drmid='docker rmi $(docker images -q -f dangling=true)'
alias drmia='docker rmi $(docker images -q)'
alias dbuild='docker build'
alias dpull='docker pull'
alias dpush='docker push'

# Container execution
alias dex='docker exec -it'
alias dsh='docker exec -it'
alias dbash='docker exec -it'
alias dlog='docker logs'
alias dlogf='docker logs -f'
alias dlogt='docker logs --tail'

# Volume management
alias dv='docker volume'
alias dvl='docker volume ls'
alias dvc='docker volume create'
alias dvd='docker volume rm'
alias dvp='docker volume prune'

# Network management
alias dn='docker network'
alias dnl='docker network ls'
alias dnc='docker network create'
alias dnd='docker network rm'
alias dnp='docker network prune'

# System management
alias dsys='docker system'
alias dsysdf='docker system df'
alias dsysprune='docker system prune'
alias dsysprunea='docker system prune -a'
alias dsysprunef='docker system prune -f'

# Docker Compose specific
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcupb='docker-compose up --build'
alias dcupbd='docker-compose up --build -d'
alias dcdown='docker-compose down'
alias dcdownv='docker-compose down -v'
alias dcbuild='docker-compose build'
alias dcbuildn='docker-compose build --no-cache'
alias dcrestart='docker-compose restart'
alias dclogs='docker-compose logs'
alias dclogsf='docker-compose logs -f'
alias dcexec='docker-compose exec'
alias dcrun='docker-compose run'
alias dcps='docker-compose ps'
alias dctop='docker-compose top'

# =============================================================================
# DOCKER FUNCTIONS
# =============================================================================

# Clean up Docker resources
dclean() {
    echo "Cleaning up Docker resources..."
    docker system prune -f
    docker volume prune -f
    docker network prune -f
    echo "Docker cleanup complete!"
}

# Clean up everything (including images)
dcleanall() {
    echo "Cleaning up all Docker resources..."
    docker system prune -a -f
    docker volume prune -f
    docker network prune -f
    echo "Complete Docker cleanup finished!"
}

# Stop all running containers
dstopall() {
    echo "Stopping all running containers..."
    docker stop $(docker ps -q)
    echo "All containers stopped!"
}

# Remove all containers
drmall() {
    echo "Removing all containers..."
    docker rm -f $(docker ps -aq)
    echo "All containers removed!"
}

# Remove all images
drmiall() {
    echo "Removing all images..."
    docker rmi -f $(docker images -q)
    echo "All images removed!"
}

# Remove dangling images
drmidangling() {
    echo "Removing dangling images..."
    docker rmi $(docker images -q -f dangling=true)
    echo "Dangling images removed!"
}

# Show Docker disk usage
dusage() {
    echo "Docker disk usage:"
    docker system df
    echo
    echo "Docker volume usage:"
    docker system df -v
}

# Docker container stats
dstats() {
    docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"
}

# Run a temporary container
drun() {
    local image=${1:-ubuntu}
    local command=${2:-bash}
    echo "Running temporary container with $image..."
    docker run -it --rm $image $command
}

# Build and run a container
dbuildrun() {
    local dockerfile=${1:-Dockerfile}
    local tag=${2:-temp}
    echo "Building $dockerfile..."
    docker build -f $dockerfile -t $tag .
    echo "Running container..."
    docker run -it --rm $tag
}

# Docker Compose functions
dcup() {
    local service=${1:-}
    if [ -n "$service" ]; then
        echo "Starting $service service..."
        docker-compose up -d $service
    else
        echo "Starting all services..."
        docker-compose up -d
    fi
}

dcdown() {
    local service=${1:-}
    if [ -n "$service" ]; then
        echo "Stopping $service service..."
        docker-compose stop $service
    else
        echo "Stopping all services..."
        docker-compose down
    fi
}

dcrebuild() {
    local service=${1:-}
    if [ -n "$service" ]; then
        echo "Rebuilding $service service..."
        docker-compose build --no-cache $service
        docker-compose up -d $service
    else
        echo "Rebuilding all services..."
        docker-compose build --no-cache
        docker-compose up -d
    fi
}

# Docker health check
dhealth() {
    echo "Docker health check:"
    echo "Docker version: $(docker --version)"
    echo "Docker Compose version: $(docker-compose --version)"
    echo
    echo "Running containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    echo
    echo "Docker system info:"
    docker system df
}

# Docker backup
dbackup() {
    local backup_dir=${1:-./docker-backup}
    local timestamp=$(date +%Y%m%d-%H%M%S)
    
    echo "Creating Docker backup in $backup_dir..."
    mkdir -p "$backup_dir"
    
    # Backup images
    echo "Backing up images..."
    docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>" | while read image; do
        local filename=$(echo $image | tr '/' '_' | tr ':' '_')
        docker save $image | gzip > "$backup_dir/${filename}_${timestamp}.tar.gz"
    done
    
    # Backup volumes
    echo "Backing up volumes..."
    docker volume ls --format "{{.Name}}" | while read volume; do
        docker run --rm -v $volume:/data -v $(pwd)/$backup_dir:/backup alpine tar czf /backup/${volume}_${timestamp}.tar.gz -C /data .
    done
    
    echo "Backup completed in $backup_dir"
}

# Docker restore
drestore() {
    local backup_dir=${1:-./docker-backup}
    
    if [ ! -d "$backup_dir" ]; then
        echo "ERROR: Backup directory $backup_dir not found!"
        return 1
    fi
    
    echo "Restoring Docker from $backup_dir..."
    
    # Restore images
    echo "Restoring images..."
    find "$backup_dir" -name "*.tar.gz" -exec docker load -i {} \;
    
    echo "Restore completed!"
}

# Docker logs with filtering
dlogf() {
    local container=${1:-}
    local pattern=${2:-}
    
    if [ -z "$container" ]; then
        echo "Usage: dlogf <container> [pattern]"
        return 1
    fi
    
    if [ -n "$pattern" ]; then
        docker logs -f $container 2>&1 | grep --color=always "$pattern"
    else
        docker logs -f $container
    fi
}

# Docker port mapping
dports() {
    echo "Docker port mappings:"
    docker ps --format "table {{.Names}}\t{{.Ports}}"
}

# Docker environment variables
denv() {
    local container=${1:-}
    if [ -z "$container" ]; then
        echo "Usage: denv <container>"
        return 1
    fi
    
    echo "Environment variables for $container:"
    docker exec $container env | sort
}

# Docker file system
dfs() {
    local container=${1:-}
    if [ -z "$container" ]; then
        echo "Usage: dfs <container>"
        return 1
    fi
    
    echo "File system for $container:"
    docker exec $container df -h
}

# Docker processes
dps() {
    local container=${1:-}
    if [ -z "$container" ]; then
        echo "Usage: dps <container>"
        return 1
    fi
    
    echo "Processes in $container:"
    docker exec $container ps aux
}

# =============================================================================
# DOCKER COMPLETION
# =============================================================================

# Docker completion
if [ -f /usr/share/bash-completion/completions/docker ]; then
    . /usr/share/bash-completion/completions/docker
fi

# Docker Compose completion
if [ -f /usr/share/bash-completion/completions/docker-compose ]; then
    . /usr/share/bash-completion/completions/docker-compose
fi

# =============================================================================
# DOCKER UTILITIES
# =============================================================================

# Docker version check
dversion() {
    echo " Docker version:"
    docker --version
    echo " Docker Compose version:"
    docker-compose --version
    echo " Docker info:"
    docker info
}

# Docker network inspection
dnet() {
    local network=${1:-}
    if [ -z "$network" ]; then
        echo " Available networks:"
        docker network ls
    else
        echo " Network details for $network:"
        docker network inspect $network
    fi
}

# Docker volume inspection
dvol() {
    local volume=${1:-}
    if [ -z "$volume" ]; then
        echo " Available volumes:"
        docker volume ls
    else
        echo " Volume details for $volume:"
        docker volume inspect $volume
    fi
}

echo "Docker aliases and functions loaded!"
echo "Try: dclean, dstopall, dusage, dhealth, dbackup"
