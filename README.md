# DevOps Dotfiles

A collaborative, open source repository for DevOps environment configuration and automation.

[![Cross-Platform](https://img.shields.io/badge/Cross--Platform-Linux%20%7C%20macOS%20%7C%20Windows-blue)](https://github.com/iinsys/dotfiles)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Documentation](https://img.shields.io/badge/Documentation-GitHub%20Pages-blue)](https://iinsys.github.io/dotfiles/)
[![GitHub Stars](https://img.shields.io/github/stars/iinsys/dotfiles?style=social)](https://github.com/iinsys/dotfiles)

## 📖 About

DevOps Dotfiles is a comprehensive collection of standardized environment configurations for DevOps engineers. It provides ready-to-use shell aliases, editor settings, Git configurations, and DevOps tool setups that boost productivity across Linux, macOS, and Windows environments. The project includes automated installation scripts, cross-platform compatibility, and extensive documentation to get teams productive quickly.

## 🚀 Quick Start

### Prerequisites
- Git
- Make ([Install Make](https://www.gnu.org/software/make/))
- A Unix-like system (Linux, macOS, WSL)

### Installation Options

#### Option 1: Automated Installation (Recommended)
```bash
# Clone the repository
git clone https://github.com/iinsys/dotfiles.git
cd dotfiles

# Install everything
make install

# Or install specific components
make install-shell    # Shell configurations only
make install-editors  # Editor configurations only
make install-git      # Git configurations only
make install-tools    # DevOps tools only
```

#### Option 2: Installation Script
```bash
# Clone and run installation script
git clone https://github.com/iinsys/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

#### Option 3: Manual Installation
```bash
# Install shell configurations
cp shell/.bashrc ~/.bashrc
cp shell/.zshrc ~/.zshrc

# Install Git configuration
cp git/.gitconfig ~/.gitconfig
cp git/.gitignore_global ~/.gitignore_global

# Install editor configurations
cp editors/.vimrc ~/.vimrc
cp editors/.nanorc ~/.nanorc
```

### Post-Installation
Restart your shell or run:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## 🛠️ What's Included

### Shell Configurations
- **80+ productivity aliases** for Git, Docker, Kubernetes, Terraform, AWS
- **Custom functions** for common DevOps tasks (cleanup, backup, health checks)
- **Enhanced prompts** with Git status and environment info
- **Auto-completion** for kubectl, Docker, AWS CLI
- **Cross-platform compatibility** (Bash & Zsh)

### Editor Configurations
- **Vim**: Syntax highlighting, key mappings, file-type specific settings
- **Nano**: DevOps syntax highlighting for YAML, Docker, Terraform
- **VS Code**: Optimized settings, recommended extensions, language-specific configurations

### Git Configuration
- **100+ Git aliases** for all operations (commit, branch, merge, etc.)
- **Conventional commit aliases** (feat:, fix:, docs:, etc.)
- **Global gitignore** with comprehensive DevOps patterns
- **Color-coded output** and enhanced formatting
- **Security best practices** built-in

### DevOps Tools
- **Docker**: Comprehensive aliases, functions, and development environment templates
- **Kubernetes**: Multi-cluster configurations, kubectl aliases, context switching
- **Terraform**: Variable templates, aliases, security scanning, cost estimation
- **AWS CLI**: Profile management, common operations, and best practices

## 🔧 Customization

All configurations are designed to be easily customizable:

### Local Override Files
Create local customization files that won't be overwritten:
- `~/.bashrc.local` - Local bash customizations
- `~/.zshrc.local` - Local zsh customizations
- `~/.gitconfig.local` - Local Git settings
- `~/.vimrc.local` - Local vim customizations
- `~/.nanorc.local` - Local nano customizations

### Makefile Commands
Use the comprehensive Makefile for easy management:
```bash
make help           # Show all available commands
make install        # Install all configurations
make install-shell  # Install shell configurations only
make install-git    # Install Git configurations only
make validate       # Validate all configurations
make test          # Run all tests
make backup        # Backup existing configurations
make clean         # Clean temporary files
make docs          # Generate documentation
make docs-serve    # Serve documentation locally
```

### Cross-Platform Support
- **Linux**: Ubuntu, Debian, CentOS, RHEL, Fedora, Arch
- **macOS**: With Homebrew support
- **Windows**: WSL, Cygwin, MSYS
- **FreeBSD**: Full support

## 📚 Documentation

- **Online Documentation**: [https://iinsys.github.io/dotfiles/](https://iinsys.github.io/dotfiles/)
- **Individual Component Docs**: Each directory contains detailed README files
- **Interactive Installation**: Use the web interface for guided setup
- **API Reference**: Complete list of aliases and functions

## 🤝 Contributing

We welcome contributions! Here's how to help:

### Adding New Configurations
1. Fork the repository
2. Add your configuration to the appropriate directory
3. Update the relevant README.md with documentation
4. Test your changes with `make validate` and `make test`
5. Submit a pull request

### Reporting Issues
- Use GitHub Issues to report bugs or request features
- Include your OS and shell information
- Provide steps to reproduce any problems

### Code of Conduct
- Be respectful and inclusive
- Focus on practical, useful configurations
- Keep things simple and well-documented
- Follow the existing code style (no emojis in scripts)

## 🚀 Features

### Key Benefits
- **Fast Onboarding**: New team members get productive immediately
- **Consistent Environment**: Same tools and aliases across all machines
- **Productivity Boost**: 80+ aliases save hours of typing
- **Best Practices**: Built-in security and DevOps patterns
- **Easy Customization**: Local override files for personal preferences
- **Professional Quality**: No emojis in scripts, clean code, comprehensive documentation

### Automation Features
- **Cross-platform installation script** with OS detection
- **Comprehensive Makefile** with 40+ commands
- **Automated documentation deployment** via GitHub Actions
- **Validation and testing** for all configurations
- **Backup and restore** functionality

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Contributors who have shared their configurations
- The DevOps community for best practices and feedback
- Open source projects that make our work easier
- Kubernetes, Docker, and Terraform communities for inspiration

## 📞 Support

- **Documentation**: [https://iinsys.github.io/dotfiles/](https://iinsys.github.io/dotfiles/)
- **Issues**: Use GitHub Issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Make Commands**: Run `make help` for all available commands

---

**Note**: This repository is designed to be practical and not overly complex. If you find any configuration too complicated or unnecessary, feel free to customize or remove it. The goal is to make DevOps work more efficient, not to add complexity.