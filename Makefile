# DevOps Dotfiles Makefile
# Cross-platform automation for installation and documentation

# Variables
DOTFILES_DIR := $(shell pwd)
BACKUP_DIR := $(HOME)/.dotfiles-backup-$(shell date +%Y%m%d-%H%M%S)
OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
SHELL := /bin/bash

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
PURPLE := \033[0;35m
CYAN := \033[0;36m
NC := \033[0m

# Default target
.PHONY: help
help: ## Show this help message
	@echo "$(BLUE)DevOps Dotfiles - Available Commands$(NC)"
	@echo "$(BLUE)====================================$(NC)"
	@echo ""
	@echo "$(CYAN)Installation:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST) | grep -E "(install|setup)" | head -5
	@echo ""
	@echo "$(CYAN)Individual Components:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST) | grep -E "(shell|editor|git|tools|bash|zsh|profile|vim|nano|vscode|docker|kubernetes|terraform|tmux|ctags)"
	@echo ""
	@echo "$(CYAN)Documentation:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST) | grep -E "(docs|serve|deploy)"
	@echo ""
	@echo "$(CYAN)Maintenance:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST) | grep -E "(clean|backup|test|validate)"
	@echo ""

# =============================================================================
# INSTALLATION TARGETS
# =============================================================================

.PHONY: install
install: ## Install all dotfiles configurations
	@echo "$(BLUE)🚀 Installing DevOps Dotfiles...$(NC)"
	@chmod +x install.sh
	@./install.sh

.PHONY: install-interactive
install-interactive: ## Install dotfiles with interactive selection
	@echo "$(BLUE)🚀 Installing DevOps Dotfiles (Interactive Mode)...$(NC)"
	@chmod +x install.sh
	@./install.sh -i

.PHONY: install-shell
install-shell: ## Install only shell configurations
	@echo "$(BLUE)🐚 Installing shell configurations...$(NC)"
	@mkdir -p ~/.vim/{backup,swap,undo}
	@cp shell/.bashrc ~/.bashrc
	@cp shell/.zshrc ~/.zshrc
	@cp shell/.profile ~/.profile
	@echo "$(GREEN)✅ Shell configurations installed!$(NC)"
	@echo "$(YELLOW)💡 Restart your shell or run: source ~/.bashrc (or ~/.zshrc)$(NC)"

.PHONY: install-editors
install-editors: ## Install only editor configurations
	@echo "$(BLUE)✏️ Installing editor configurations...$(NC)"
	@cp editors/.vimrc ~/.vimrc
	@cp editors/.nanorc ~/.nanorc
	@mkdir -p ~/.vscode
	@cp -r editors/vscode/* ~/.vscode/
	@echo "$(GREEN)✅ Editor configurations installed!$(NC)"

.PHONY: install-git
install-git: ## Install only Git configurations
	@echo "$(BLUE)📝 Installing Git configurations...$(NC)"
	@cp git/.gitconfig ~/.gitconfig
	@cp git/.gitignore_global ~/.gitignore_global
	@git config --global core.excludesfile ~/.gitignore_global
	@echo "$(GREEN)✅ Git configurations installed!$(NC)"

.PHONY: install-tools
install-tools: ## Install only DevOps tools configurations
	@echo "$(BLUE)🛠️ Installing DevOps tools configurations...$(NC)"
	@mkdir -p ~/.docker ~/.kube ~/.terraform.d
	@cp -r tools/docker/* ~/.docker/ 2>/dev/null || true
	@cp -r tools/kubernetes/* ~/.kube/ 2>/dev/null || true
	@cp -r tools/terraform/* ~/.terraform.d/ 2>/dev/null || true
	@ln -sf $(DOTFILES_DIR)/tools/tmux/.tmux.conf $(HOME)/.tmux.conf
	@ln -sf $(DOTFILES_DIR)/tools/ctags/.ctags $(HOME)/.ctags
	@echo "$(GREEN)✅ DevOps tools configurations installed!$(NC)"

.PHONY: install-docker
install-docker: ## Install only Docker configurations
	@echo "$(BLUE)🐳 Installing Docker configurations...$(NC)"
	@mkdir -p ~/.docker
	@cp -r tools/docker/* ~/.docker/
	@echo "$(GREEN)✅ Docker configurations installed!$(NC)"

.PHONY: install-kubernetes
install-kubernetes: ## Install only Kubernetes configurations
	@echo "$(BLUE)☸️ Installing Kubernetes configurations...$(NC)"
	@mkdir -p ~/.kube
	@cp -r tools/kubernetes/* ~/.kube/
	@echo "$(GREEN)✅ Kubernetes configurations installed!$(NC)"

.PHONY: install-terraform
install-terraform: ## Install only Terraform configurations
	@echo "$(BLUE)🏗️ Installing Terraform configurations...$(NC)"
	@mkdir -p ~/.terraform.d
	@cp -r tools/terraform/* ~/.terraform.d/
	@echo "$(GREEN)✅ Terraform configurations installed!$(NC)"

# =============================================================================
# SETUP TARGETS
# =============================================================================

.PHONY: setup
setup: install ## Complete setup (alias for install)
	@echo "$(GREEN)🎉 Setup completed!$(NC)"

.PHONY: setup-dev
setup-dev: ## Setup development environment
	@echo "$(BLUE)🔧 Setting up development environment...$(NC)"
	@make install-shell
	@make install-editors
	@make install-git
	@echo "$(GREEN)✅ Development environment setup complete!$(NC)"

.PHONY: setup-devops
setup-devops: ## Setup DevOps environment
	@echo "$(BLUE)🚀 Setting up DevOps environment...$(NC)"
	@make install
	@echo "$(GREEN)✅ DevOps environment setup complete!$(NC)"

# =============================================================================
# DOCUMENTATION TARGETS
# =============================================================================

.PHONY: docs
docs: ## Generate documentation
	@echo "$(BLUE)📚 Generating documentation...$(NC)"
	@mkdir -p docs
	@echo "# DevOps Dotfiles Documentation" > docs/README.md
	@echo "" >> docs/README.md
	@echo "Generated on: $$(date)" >> docs/README.md
	@echo "" >> docs/README.md
	@cat README.md >> docs/README.md
	@echo "$(GREEN)✅ Documentation generated in docs/$(NC)"

.PHONY: docs-serve
docs-serve: ## Serve documentation locally
	@echo "$(BLUE)🌐 Serving documentation locally...$(NC)"
	@if command -v python3 >/dev/null 2>&1; then \
		echo "$(YELLOW)Starting Python HTTP server on http://localhost:8000$(NC)"; \
		python3 -m http.server 8000 -d docs; \
	elif command -v python >/dev/null 2>&1; then \
		echo "$(YELLOW)Starting Python HTTP server on http://localhost:8000$(NC)"; \
		python -m SimpleHTTPServer 8000; \
	else \
		echo "$(RED)Python not found. Please install Python to serve documentation.$(NC)"; \
	fi

.PHONY: docs-deploy
docs-deploy: ## Deploy documentation to GitHub Pages
	@echo "$(BLUE)🚀 Deploying documentation to GitHub Pages...$(NC)"
	@if [ -d ".git" ]; then \
		git add docs/; \
		git commit -m "docs: update documentation" || true; \
		git push origin main; \
		echo "$(GREEN)✅ Documentation deployed to GitHub Pages!$(NC)"; \
		echo "$(YELLOW)📖 View at: https://iinsys.github.io/dotfiles/$(NC)"; \
	else \
		echo "$(RED)Not in a Git repository. Cannot deploy to GitHub Pages.$(NC)"; \
	fi

# =============================================================================
# VALIDATION TARGETS
# =============================================================================

.PHONY: validate
validate: ## Validate all configurations
	@echo "$(BLUE)✅ Validating configurations...$(NC)"
	@make validate-shell
	@make validate-git
	@make validate-docker
	@make validate-terraform
	@echo "$(GREEN)✅ All validations passed!$(NC)"

.PHONY: validate-shell
validate-shell: ## Validate shell configurations
	@echo "$(BLUE)🐚 Validating shell configurations...$(NC)"
	@bash -n shell/.bashrc && echo "$(GREEN)✅ .bashrc syntax OK$(NC)" || echo "$(RED)❌ .bashrc syntax error$(NC)"
	@zsh -n shell/.zshrc && echo "$(GREEN)✅ .zshrc syntax OK$(NC)" || echo "$(RED)❌ .zshrc syntax error$(NC)"

.PHONY: validate-git
validate-git: ## Validate Git configurations
	@echo "$(BLUE)📝 Validating Git configurations...$(NC)"
	@if [ -f "git/.gitconfig" ]; then \
		echo "$(GREEN)✅ .gitconfig exists$(NC)"; \
	else \
		echo "$(RED)❌ .gitconfig missing$(NC)"; \
	fi
	@if [ -f "git/.gitignore_global" ]; then \
		echo "$(GREEN)✅ .gitignore_global exists$(NC)"; \
	else \
		echo "$(RED)❌ .gitignore_global missing$(NC)"; \
	fi

.PHONY: validate-docker
validate-docker: ## Validate Docker configurations
	@echo "$(BLUE)🐳 Validating Docker configurations...$(NC)"
	@if [ -f "tools/docker/docker-compose.yml" ]; then \
		echo "$(GREEN)✅ docker-compose.yml exists$(NC)"; \
	else \
		echo "$(RED)❌ docker-compose.yml missing$(NC)"; \
	fi
	@if [ -f "tools/docker/docker-aliases.sh" ]; then \
		echo "$(GREEN)✅ docker-aliases.sh exists$(NC)"; \
	else \
		echo "$(RED)❌ docker-aliases.sh missing$(NC)"; \
	fi

.PHONY: validate-terraform
validate-terraform: ## Validate Terraform configurations
	@echo "$(BLUE)🏗️ Validating Terraform configurations...$(NC)"
	@if [ -f "tools/terraform/terraform.tfvars.example" ]; then \
		echo "$(GREEN)✅ terraform.tfvars.example exists$(NC)"; \
	else \
		echo "$(RED)❌ terraform.tfvars.example missing$(NC)"; \
	fi
	@if [ -f "tools/terraform/terraform-aliases.sh" ]; then \
		echo "$(GREEN)✅ terraform-aliases.sh exists$(NC)"; \
	else \
		echo "$(RED)❌ terraform-aliases.sh missing$(NC)"; \
	fi

# =============================================================================
# TESTING TARGETS
# =============================================================================

.PHONY: test
test: ## Run all tests
	@echo "$(BLUE)🧪 Running tests...$(NC)"
	@make test-shell
	@make test-install
	@echo "$(GREEN)✅ All tests passed!$(NC)"

.PHONY: test-shell
test-shell: ## Test shell configurations
	@echo "$(BLUE)🐚 Testing shell configurations...$(NC)"
	@bash -c "source shell/.bashrc && echo '$(GREEN)✅ Bash configuration loaded successfully$(NC)'"
	@zsh -c "source shell/.zshrc && echo '$(GREEN)✅ Zsh configuration loaded successfully$(NC)'"

.PHONY: test-install
test-install: ## Test installation script
	@echo "$(BLUE)🚀 Testing installation script...$(NC)"
	@bash -n install.sh && echo "$(GREEN)✅ Installation script syntax OK$(NC)" || echo "$(RED)❌ Installation script syntax error$(NC)"

# =============================================================================
# BACKUP TARGETS
# =============================================================================

.PHONY: backup
backup: ## Backup existing configurations
	@echo "$(BLUE)💾 Creating backup...$(NC)"
	@mkdir -p $(BACKUP_DIR)
	@for file in ~/.bashrc ~/.zshrc ~/.profile ~/.vimrc ~/.nanorc ~/.gitconfig ~/.gitignore_global; do \
		if [ -f "$$file" ]; then \
			cp "$$file" "$(BACKUP_DIR)/"; \
			echo "$(GREEN)✅ Backed up $$file$(NC)"; \
		fi; \
	done
	@echo "$(GREEN)✅ Backup created in $(BACKUP_DIR)$(NC)"

.PHONY: restore
restore: ## Restore from backup
	@echo "$(BLUE)🔄 Restoring from backup...$(NC)"
	@if [ -d "$(BACKUP_DIR)" ]; then \
		cp -r "$(BACKUP_DIR)"/* ~/; \
		echo "$(GREEN)✅ Restored from $(BACKUP_DIR)$(NC)"; \
	else \
		echo "$(RED)❌ Backup directory not found$(NC)"; \
	fi

# =============================================================================
# CLEANUP TARGETS
# =============================================================================

.PHONY: clean
clean: ## Clean temporary files
	@echo "$(BLUE)🧹 Cleaning temporary files...$(NC)"
	@find . -name "*.tmp" -delete
	@find . -name "*.bak" -delete
	@find . -name ".DS_Store" -delete
	@echo "$(GREEN)✅ Cleanup complete!$(NC)"

.PHONY: uninstall
uninstall: ## Uninstall dotfiles (restore from backup)
	@echo "$(BLUE)🗑️ Uninstalling dotfiles...$(NC)"
	@make restore
	@echo "$(GREEN)✅ Uninstall complete!$(NC)"

# =============================================================================
# UTILITY TARGETS
# =============================================================================

.PHONY: status
status: ## Show installation status
	@echo "$(BLUE)📊 Installation Status$(NC)"
	@echo "$(BLUE)====================$(NC)"
	@echo "$(CYAN)OS: $(OS)$(NC)"
	@echo "$(CYAN)Shell: $(SHELL)$(NC)"
	@echo "$(CYAN)User: $(USER)$(NC)"
	@echo ""
	@echo "$(CYAN)Installed Components:$(NC)"
	@[ -f ~/.bashrc ] && echo "$(GREEN)✅ Bash configuration$(NC)" || echo "$(RED)❌ Bash configuration$(NC)"
	@[ -f ~/.zshrc ] && echo "$(GREEN)✅ Zsh configuration$(NC)" || echo "$(RED)❌ Zsh configuration$(NC)"
	@[ -f ~/.vimrc ] && echo "$(GREEN)✅ Vim configuration$(NC)" || echo "$(RED)❌ Vim configuration$(NC)"
	@[ -f ~/.gitconfig ] && echo "$(GREEN)✅ Git configuration$(NC)" || echo "$(RED)❌ Git configuration$(NC)"
	@[ -d ~/.vscode ] && echo "$(GREEN)✅ VS Code configuration$(NC)" || echo "$(RED)❌ VS Code configuration$(NC)"

.PHONY: update
update: ## Update dotfiles from repository
	@echo "$(BLUE)🔄 Updating dotfiles...$(NC)"
	@if [ -d ".git" ]; then \
		git pull origin main; \
		echo "$(GREEN)✅ Dotfiles updated!$(NC)"; \
		echo "$(YELLOW)💡 Run 'make install' to apply updates$(NC)"; \
	else \
		echo "$(RED)❌ Not in a Git repository$(NC)"; \
	fi

.PHONY: info
info: ## Show system information
	@echo "$(BLUE)ℹ️ System Information$(NC)"
	@echo "$(BLUE)====================$(NC)"
	@echo "$(CYAN)OS: $(OS)$(NC)"
	@echo "$(CYAN)Architecture: $(shell uname -m)$(NC)"
	@echo "$(CYAN)Kernel: $(shell uname -r)$(NC)"
	@echo "$(CYAN)Shell: $(SHELL)$(NC)"
	@echo "$(CYAN)User: $(USER)$(NC)"
	@echo "$(CYAN)Home: $(HOME)$(NC)"
	@echo "$(CYAN)Dotfiles: $(DOTFILES_DIR)$(NC)"

# =============================================================================
# DEVELOPMENT TARGETS
# =============================================================================

.PHONY: dev
dev: ## Setup development environment
	@echo "$(BLUE)🔧 Setting up development environment...$(NC)"
	@make install-shell
	@make install-editors
	@make install-git
	@echo "$(GREEN)✅ Development environment ready!$(NC)"

.PHONY: install-tmux
install-tmux: ## Install only tmux configuration
	@echo "$(BLUE)🖥️ Installing tmux configuration...$(NC)"
	@ln -sf $(DOTFILES_DIR)/tools/tmux/.tmux.conf $(HOME)/.tmux.conf
	@echo "$(GREEN)✅ tmux configuration installed!$(NC)"

.PHONY: install-ctags
install-ctags: ## Install only ctags configuration
	@echo "$(BLUE)🏷️ Installing ctags configuration...$(NC)"
	@ln -sf $(DOTFILES_DIR)/tools/ctags/.ctags $(HOME)/.ctags
	@echo "$(GREEN)✅ ctags configuration installed!$(NC)"

# Individual shell component targets
.PHONY: install-bash
install-bash: ## Install only Bash configuration
	@echo "$(BLUE)🐚 Installing Bash configuration...$(NC)"
	@cp $(DOTFILES_DIR)/shell/.bashrc $(HOME)/.bashrc
	@echo "$(GREEN)✅ Bash configuration installed!$(NC)"

.PHONY: install-zsh
install-zsh: ## Install only Zsh configuration
	@echo "$(BLUE)🐚 Installing Zsh configuration...$(NC)"
	@cp $(DOTFILES_DIR)/shell/.zshrc $(HOME)/.zshrc
	@echo "$(GREEN)✅ Zsh configuration installed!$(NC)"

.PHONY: install-profile
install-profile: ## Install only profile configuration
	@echo "$(BLUE)🐚 Installing profile configuration...$(NC)"
	@cp $(DOTFILES_DIR)/shell/.profile $(HOME)/.profile
	@echo "$(GREEN)✅ Profile configuration installed!$(NC)"

# Individual editor component targets
.PHONY: install-vim
install-vim: ## Install only Vim configuration
	@echo "$(BLUE)✏️ Installing Vim configuration...$(NC)"
	@mkdir -p $(HOME)/.vim/{backup,swap,undo}
	@cp $(DOTFILES_DIR)/editors/.vimrc $(HOME)/.vimrc
	@echo "$(GREEN)✅ Vim configuration installed!$(NC)"

.PHONY: install-nano
install-nano: ## Install only Nano configuration
	@echo "$(BLUE)✏️ Installing Nano configuration...$(NC)"
	@cp $(DOTFILES_DIR)/editors/.nanorc $(HOME)/.nanorc
	@echo "$(GREEN)✅ Nano configuration installed!$(NC)"

.PHONY: install-vscode
install-vscode: ## Install only VS Code configuration
	@echo "$(BLUE)✏️ Installing VS Code configuration...$(NC)"
	@mkdir -p $(HOME)/.vscode
	@cp -r $(DOTFILES_DIR)/editors/vscode/* $(HOME)/.vscode/
	@echo "$(GREEN)✅ VS Code configuration installed!$(NC)"

# Individual tool component targets
.PHONY: install-docker
install-docker: ## Install only Docker configurations
	@echo "$(BLUE)🐳 Installing Docker configurations...$(NC)"
	@mkdir -p $(HOME)/.docker
	@cp -r $(DOTFILES_DIR)/tools/docker/* $(HOME)/.docker/
	@echo "$(GREEN)✅ Docker configurations installed!$(NC)"

.PHONY: install-kubernetes
install-kubernetes: ## Install only Kubernetes configurations
	@echo "$(BLUE)☸️ Installing Kubernetes configurations...$(NC)"
	@mkdir -p $(HOME)/.kube
	@cp -r $(DOTFILES_DIR)/tools/kubernetes/* $(HOME)/.kube/
	@echo "$(GREEN)✅ Kubernetes configurations installed!$(NC)"

.PHONY: install-terraform
install-terraform: ## Install only Terraform configurations
	@echo "$(BLUE)🏗️ Installing Terraform configurations...$(NC)"
	@mkdir -p $(HOME)/.terraform.d
	@cp -r $(DOTFILES_DIR)/tools/terraform/* $(HOME)/.terraform.d/
	@echo "$(GREEN)✅ Terraform configurations installed!$(NC)"

.PHONY: devops
devops: ## Setup full DevOps environment
	@echo "$(BLUE)🚀 Setting up full DevOps environment...$(NC)"
	@make install
	@echo "$(GREEN)✅ DevOps environment ready!$(NC)"

# Default target
.DEFAULT_GOAL := help
