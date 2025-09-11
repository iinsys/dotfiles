# Editor Configurations

This directory contains editor and IDE configuration files optimized for DevOps work.

## Files

- **`.vimrc`** - Vim configuration with DevOps-friendly settings
- **`.nanorc`** - Nano configuration with syntax highlighting
- **`vscode/`** - VS Code settings and extensions

## Vim Configuration (`.vimrc`)

### Features
- **Line numbers** with relative numbering
- **Syntax highlighting** for all file types
- **Auto-indentation** and smart indentation
- **Tab settings** optimized for different file types
- **Key mappings** for common DevOps tasks
- **Custom functions** for formatting and cleanup

### Key Mappings
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>c` - Clear search highlighting
- `<leader>n` - Toggle line numbers
- `<leader>p` - Toggle paste mode
- `<leader>t` - Toggle between tabs and spaces
- `<leader>j` - Format JSON

### File Type Settings
- **YAML**: 2-space indentation
- **JSON**: 2-space indentation
- **Dockerfile**: 2-space indentation
- **Terraform**: 2-space indentation
- **Shell scripts**: 2-space indentation
- **Python**: 4-space indentation
- **Go**: 4-space tabs

## Nano Configuration (`.nanorc`)

### Features
- **Line numbers** enabled
- **Mouse support** enabled
- **Auto-indentation** enabled
- **Syntax highlighting** for DevOps file types
- **Tab completion** enabled
- **Backup files** enabled

### Syntax Highlighting
- **YAML files** (`.yml`, `.yaml`)
- **Dockerfile** (`Dockerfile*`)
- **Terraform files** (`.tf`)
- **Kubernetes YAML** (`k8s-*.yml`)

## VS Code Configuration

### Settings (`vscode/settings.json`)

#### Editor Settings
- **Font**: Fira Code with ligatures
- **Font size**: 14px
- **Line numbers**: Enabled
- **Rulers**: 80 and 120 characters
- **Word wrap**: Enabled at 120 characters
- **Tab size**: 2 spaces (configurable per language)
- **Format on save**: Enabled
- **Auto-save**: Enabled with 1-second delay

#### File Settings
- **Trim trailing whitespace**: Enabled
- **Insert final newline**: Enabled
- **Auto-save**: Enabled
- **Exclude patterns**: Common build and cache directories

#### Terminal Settings
- **Font**: Fira Code
- **Font size**: 14px
- **Cursor**: Blinking line
- **Scrollback**: 10,000 lines
- **Shell**: Zsh (macOS) / Bash (Linux)

#### Language-Specific Settings
- **YAML**: 2-space indentation
- **JSON**: 2-space indentation
- **Terraform**: 2-space indentation
- **Dockerfile**: 2-space indentation
- **Shell scripts**: 2-space indentation
- **Python**: 4-space indentation
- **Go**: 4-space tabs

### Extensions (`vscode/extensions.json`)

#### Essential DevOps Extensions
- **Docker**: Container management
- **Kubernetes**: K8s resource management
- **Terraform**: Infrastructure as code
- **YAML**: YAML file support
- **PowerShell**: PowerShell support
- **Python**: Python development
- **Go**: Go development

#### Git and Version Control
- **GitLens**: Enhanced Git capabilities
- **GitHub Pull Requests**: GitHub integration
- **GitHub Copilot**: AI-powered coding assistance

#### Cloud and Infrastructure
- **AWS Toolkit**: AWS integration
- **Azure Tools**: Azure integration
- **Google Cloud Code**: GCP integration

#### Productivity
- **Prettier**: Code formatting
- **ESLint**: JavaScript linting
- **Markdown All in One**: Markdown support
- **Thunder Client**: API testing

## Installation

### Vim
```bash
# Copy vimrc to home directory
cp editors/.vimrc ~/.vimrc

# Create vim directories
mkdir -p ~/.vim/{backup,swap,undo}
```

### Nano
```bash
# Copy nanorc to home directory
cp editors/.nanorc ~/.nanorc
```

### VS Code
```bash
# Copy VS Code settings
cp -r editors/vscode ~/.vscode

# Or manually copy settings
cp editors/vscode/settings.json ~/.vscode/settings.json
cp editors/vscode/extensions.json ~/.vscode/extensions.json
```

## Customization

### Local Overrides
Create local customization files:
- `~/.vimrc.local` - Local vim customizations
- `~/.nanorc.local` - Local nano customizations
- `~/.vscode/settings.local.json` - Local VS Code settings

### Adding New File Types
To add syntax highlighting for new file types:

#### Vim
```vim
" Add to .vimrc
autocmd FileType newtype setlocal tabstop=2 shiftwidth=2 expandtab
```

#### Nano
```bash
# Add to .nanorc
syntax "newtype" "\.newtype$"
color brightblue "keyword1"
color brightgreen "keyword2"
```

#### VS Code
```json
// Add to settings.json
"[newtype]": {
  "editor.tabSize": 2,
  "editor.insertSpaces": true
}
```

## Tips

1. **Test configurations**: After making changes, test with sample files
2. **Keep it simple**: Don't add too many customizations
3. **Use local files**: Keep personal customizations in `.local` files
4. **Document changes**: Add comments to explain complex settings
5. **Backup existing configs**: Always backup before replacing

## Troubleshooting

### Common Issues

1. **Vim not loading config**: Check file permissions and syntax
2. **Nano syntax not working**: Ensure syntax files are available
3. **VS Code not applying settings**: Restart VS Code after changes

### Debug Commands
```bash
# Check vim config
vim --version
vim -c "echo &runtimepath"

# Check nano config
nano --version

# Check VS Code settings
code --list-extensions
```

## Contributing

When adding new configurations:
1. Test on multiple file types
2. Add documentation
3. Keep settings practical and commonly used
4. Consider cross-platform compatibility
5. Add to appropriate README sections
