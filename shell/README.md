# Shell Configurations

This directory contains shell configuration files optimized for DevOps work.

## Files

- **`.bashrc`** - Bash shell configuration with DevOps aliases and functions
- **`.zshrc`** - Zsh shell configuration with DevOps aliases and functions  
- **`.profile`** - Common environment variables and settings for all shells

## Features

### Aliases

#### Git Aliases
- `gs` - git status (show repository status)
- `ga` - git add (stage files)
- `gc` - git commit (commit changes)
- `gp` - git push (push to remote)
- `gl` - git log --oneline (show commit history)
- `gd` - git diff (show changes)
- `gb` - git branch (list branches)
- `gco` - git checkout (switch branches)
- `gpl` - git pull (pull from remote)
- `gst` - git stash (stash changes)
- `gstp` - git stash pop (apply and remove stash)

#### Docker Aliases
- `d` - docker (docker command)
- `dc` - docker-compose (docker-compose command)
- `dps` - docker ps (list running containers)
- `dpsa` - docker ps -a (list all containers)
- `di` - docker images (list images)
- `dex` - docker exec -it (execute in container)
- `dlog` - docker logs (show container logs)
- `dstop` - docker stop (stop container)
- `drm` - docker rm (remove container)
- `drmi` - docker rmi (remove image)

#### Kubernetes Aliases
- `k` - kubectl (kubectl command)
- `kgp` - kubectl get pods (list pods)
- `kgs` - kubectl get services (list services)
- `kgd` - kubectl get deployments (list deployments)
- `kgn` - kubectl get nodes (list nodes)
- `kdp` - kubectl describe pod (describe pod)
- `kds` - kubectl describe service (describe service)
- `kdd` - kubectl describe deployment (describe deployment)
- `klog` - kubectl logs (show pod logs)
- `kex` - kubectl exec -it (execute in pod)

#### Terraform Aliases
- `tf` - terraform (terraform command)
- `tfi` - terraform init (initialize terraform)
- `tfp` - terraform plan (plan changes)
- `tfa` - terraform apply (apply changes)
- `tfd` - terraform destroy (destroy infrastructure)
- `tfo` - terraform output (show outputs)
- `tfs` - terraform show (show state)

#### AWS Aliases
- `aws-profile` - aws configure list-profiles (list AWS profiles)
- `aws-region` - aws configure get region (get current region)

#### System Aliases
- `ll` - ls -alF (detailed file listing)
- `la` - ls -A (list all files including hidden)
- `..` - cd .. (go up one directory)
- `...` - cd ../.. (go up two directories)
- `ports` - netstat -tuln (show listening ports)
- `myip` - curl -s ifconfig.me (show public IP)
- `weather` - curl -s wttr.in (show weather)

### Advanced Functions (100+ functions)
- **Code Navigation**: `ctags()`, `findreplace()`, `glog()`, `gstatus()`, `gitinit()`, `gbranch()`
- **System Monitoring**: `dstats()`, `psaux()`, `memtop()`, `load()`, `iostat()`, `netstats()`, `sysinfo()`
- **File Operations**: `monitor()`, `dirsize()`, `backup()`, `restore()`, `tmpdir()`
- **Utility Functions**: `weather()`, `gdiffw()`, `glogf()`, `gblame()`
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
