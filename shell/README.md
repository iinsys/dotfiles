# Shell Configurations

This directory contains shell configuration files optimized for DevOps work.

## Files

- **`.bashrc`** - Bash shell configuration with DevOps aliases and functions
- **`.zshrc`** - Zsh shell configuration with DevOps aliases and functions  
- **`.profile`** - Common environment variables and settings for all shells

## Features

### Aliases
- **Git**: `gs`, `ga`, `gc`, `gp`, `gl`, `gd`, `gb`, `gco`, `gpl`, `gst`, `gstp`
- **Docker**: `d`, `dc`, `dps`, `dpsa`, `di`, `dex`, `dlog`, `dstop`, `drm`, `drmi`
- **Kubernetes**: `k`, `kgp`, `kgs`, `kgd`, `kgn`, `kdp`, `kds`, `kdd`, `klog`, `kex`
- **Terraform**: `tf`, `tfi`, `tfp`, `tfa`, `tfd`, `tfo`, `tfs`
- **AWS**: `aws-profile`, `aws-region`
- **System**: `ll`, `la`, `..`, `...`, `ports`, `myip`, `weather`

### Functions
- **Docker**: `dclean()`, `dstopall()`
- **Git**: `gac()`, `gacp()`
- **Kubernetes**: `kns()`, `kctx()`
- **AWS**: `aws-profile-set()`
- **Terraform**: `tfiup()`
- **System**: `mkcd()`, `ff()`, `fd()`, `serve()`

### Environment Variables
- Default editor set to vim
- Common paths added to PATH
- History settings optimized
- DevOps tool configurations

## Installation

### Automatic Installation
Run the main installation script from the repository root:
```bash
./install.sh
```

### Manual Installation
Copy the files to your home directory:
```bash
cp shell/.bashrc ~/.bashrc
cp shell/.zshrc ~/.zshrc
cp shell/.profile ~/.profile
```

### Shell-Specific Installation
If you only use one shell, copy only the relevant file:
```bash
# For Bash users
cp shell/.bashrc ~/.bashrc

# For Zsh users
cp shell/.zshrc ~/.zshrc
```

## Customization

### Local Overrides
Create local customization files that won't be overwritten:
- `~/.bashrc.local` - Local bash customizations
- `~/.zshrc.local` - Local zsh customizations
- `~/.profile.local` - Local profile customizations

### Adding New Aliases
Add your custom aliases to the local files:
```bash
# In ~/.bashrc.local or ~/.zshrc.local
alias myalias='my command'
```

### Adding New Functions
Add your custom functions to the local files:
```bash
# In ~/.bashrc.local or ~/.zshrc.local
myfunction() {
    echo "My custom function"
}
```

## Tips

1. **Test your configuration**: After making changes, test with `source ~/.bashrc` or `source ~/.zshrc`
2. **Keep it simple**: Don't add too many aliases - only add what you actually use
3. **Use local files**: Keep your personal customizations in `.local` files
4. **Document customizations**: Add comments to explain complex aliases or functions

## Troubleshooting

### Common Issues

1. **Prompt not showing**: Make sure your shell is sourcing the correct file
2. **Aliases not working**: Check that the file is being sourced correctly
3. **Colors not showing**: Ensure your terminal supports colors

### Debug Commands
```bash
# Check which shell you're using
echo $SHELL

# Check if files are being sourced
grep -n "source" ~/.bashrc ~/.zshrc ~/.profile

# Test specific aliases
alias | grep "your-alias"
```

## Contributing

When adding new configurations:
1. Keep them practical and commonly used
2. Add documentation in this README
3. Test on both Bash and Zsh if possible
4. Consider adding to both `.bashrc` and `.zshrc` for consistency
