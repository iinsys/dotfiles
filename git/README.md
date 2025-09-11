# Git Configuration

This directory contains Git configuration files optimized for DevOps work.

## Files

- **`.gitconfig`** - Git global configuration with DevOps-friendly settings
- **`.gitignore_global`** - Global gitignore patterns for common files

## Git Configuration (`.gitconfig`)

### Core Settings
- **Editor**: Vim as default editor
- **Default branch**: `main`
- **Color output**: Enabled
- **Line endings**: LF for cross-platform compatibility
- **Whitespace handling**: Trailing spaces and tabs before spaces

### Aliases

#### Basic Git Operations
- `st` - status
- `co` - checkout
- `br` - branch
- `ci` - commit
- `df` - diff
- `lg` - log with graph and decorations

#### Status and Information
- `s` - short status with branch
- `ss` - short status only
- `last` - last commit
- `visual` - open gitk

#### Commits
- `cm` - commit with message
- `ca` - commit all changes
- `cam` - commit all with message
- `amend` - amend last commit

#### Branches
- `b` - branch
- `ba` - all branches
- `bd` - delete branch
- `bD` - force delete branch
- `bm` - move/rename branch
- `br` - remote branches

#### Checkout
- `co` - checkout
- `cob` - checkout new branch
- `com` - checkout main
- `cod` - checkout develop

#### Merge and Rebase
- `m` - merge
- `mn` - merge no-fast-forward
- `ms` - merge squash
- `r` - rebase
- `ri` - interactive rebase
- `rc` - continue rebase
- `ra` - abort rebase
- `rs` - skip rebase

#### Stash
- `sa` - stash apply
- `sc` - stash clear
- `sd` - stash drop
- `sl` - stash list
- `sp` - stash pop
- `ss` - stash save
- `sw` - stash show

#### Remote Operations
- `r` - remote
- `ra` - remote add
- `rr` - remote remove
- `rv` - remote verbose
- `ru` - remote update
- `rp` - remote prune

#### Fetch and Pull
- `f` - fetch
- `fa` - fetch all
- `fp` - fetch prune
- `p` - pull
- `pr` - pull rebase
- `pt` - pull tags

#### Push
- `pu` - push
- `pum` - push origin main
- `pud` - push origin develop
- `put` - push tags
- `puu` - push upstream

#### Log and Show
- `l` - log oneline
- `ll` - log with graph
- `lf` - log follow
- `lp` - log patch
- `ls` - log stat
- `l1` - log last 1
- `l5` - log last 5
- `l10` - log last 10
- `sh` - show
- `shs` - show stat
- `shp` - show patch

#### Diff
- `d` - diff
- `dc` - diff cached
- `dh` - diff HEAD
- `d1` - diff HEAD~1
- `d2` - diff HEAD~2
- `d3` - diff HEAD~3

#### Reset and Clean
- `r` - reset
- `rh` - reset hard
- `rs` - reset soft
- `rm` - reset mixed
- `cl` - clean
- `clf` - clean force
- `cld` - clean force directories

#### Tags
- `t` - tag
- `ta` - tag annotated
- `td` - tag delete
- `tl` - tag list

#### Config
- `cf` - config
- `cfl` - config list
- `cfg` - config global
- `cfl` - config local

### DevOps-Specific Aliases

#### Docker
- `docker-log` - log with docker filter
- `docker-commit` - commit with docker prefix

#### Kubernetes
- `k8s-log` - log with k8s filter
- `k8s-commit` - commit with k8s prefix

#### Terraform
- `tf-log` - log with terraform filter
- `tf-commit` - commit with terraform prefix

#### AWS
- `aws-log` - log with aws filter
- `aws-commit` - commit with aws prefix

#### CI/CD
- `ci-log` - log with ci filter
- `ci-commit` - commit with ci prefix

#### Security
- `sec-log` - log with security filter
- `sec-commit` - commit with security prefix

#### Bug Fixes
- `fix-log` - log with fix filter
- `fix-commit` - commit with fix prefix

#### Features
- `feat-log` - log with feat filter
- `feat-commit` - commit with feat prefix

#### Documentation
- `docs-log` - log with docs filter
- `docs-commit` - commit with docs prefix

#### Refactoring
- `refactor-log` - log with refactor filter
- `refactor-commit` - commit with refactor prefix

#### Performance
- `perf-log` - log with perf filter
- `perf-commit` - commit with perf prefix

#### Tests
- `test-log` - log with test filter
- `test-commit` - commit with test prefix

#### Chores
- `chore-log` - log with chore filter
- `chore-commit` - commit with chore prefix

## Global Gitignore (`.gitignore_global`)

### Operating System Files
- **macOS**: `.DS_Store`, `.Spotlight-V100`, `.Trashes`
- **Windows**: `Thumbs.db`, `Desktop.ini`, `$RECYCLE.BIN/`
- **Linux**: `*~`, `.fuse_hidden*`, `.directory`

### Editor and IDE Files
- **Vim**: `*.swp`, `*.swo`, `*~`
- **Emacs**: `*~`, `\#*\#`, `*.elc`
- **VS Code**: `.vscode/`, `*.code-workspace`
- **IntelliJ**: `.idea/`, `*.iml`, `*.ipr`
- **Sublime**: `*.sublime-project`, `*.sublime-workspace`

### Programming Languages
- **Python**: `__pycache__/`, `*.pyc`, `venv/`, `.env`
- **Node.js**: `node_modules/`, `npm-debug.log*`, `.env`
- **Go**: `*.exe`, `*.test`, `*.out`
- **Java**: `*.class`, `*.jar`, `*.war`
- **C/C++**: `*.o`, `*.a`, `*.so`
- **Rust**: `target/`, `Cargo.lock`

### DevOps and Infrastructure
- **Terraform**: `*.tfstate`, `*.tfvars`, `.terraform/`
- **Ansible**: `*.retry`, `.ansible/`
- **Docker**: `docker-compose.override.yml`
- **Kubernetes**: `*.kubeconfig`, `.kube/`
- **Vagrant**: `.vagrant/`
- **Packer**: `packer_cache/`, `*.box`

### Cloud Providers
- **AWS**: `.aws/`, `aws-exports.js`
- **Azure**: `.azure/`
- **Google Cloud**: `.gcloud/`, `service-account-key.json`

### CI/CD
- **Jenkins**: `.jenkins/`, `jenkins.log`
- **GitHub Actions**: `.github/workflows/*.yml.bak`
- **GitLab CI**: `.gitlab-ci.yml.bak`
- **CircleCI**: `.circleci/config.yml.bak`
- **Travis CI**: `.travis.yml.bak`

### Security
- **Secrets**: `*.pem`, `*.key`, `*.crt`, `secrets/`
- **SSH**: `.ssh/`, `id_rsa`, `known_hosts`
- **GPG**: `*.gpg`, `*.asc`

### Databases
- **SQLite**: `*.sqlite`, `*.sqlite3`
- **PostgreSQL**: `*.dump`, `*.sql`
- **MySQL**: `*.sql`, `*.dump`
- **MongoDB**: `*.bson`

## Installation

### Automatic Installation
Run the main installation script from the repository root:
```bash
./install.sh
```

### Manual Installation
```bash
# Copy gitconfig to home directory
cp git/.gitconfig ~/.gitconfig

# Copy global gitignore
cp git/.gitignore_global ~/.gitignore_global

# Configure git to use global gitignore
git config --global core.excludesfile ~/.gitignore_global
```

### User Configuration
Edit the `.gitconfig` file to set your name and email:
```bash
# Set your name and email
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Customization

### Local Overrides
Create a local configuration file:
```bash
# Create local gitconfig
touch ~/.gitconfig.local

# Add local settings
echo "[user]" >> ~/.gitconfig.local
echo "    name = Your Name" >> ~/.gitconfig.local
echo "    email = your.email@example.com" >> ~/.gitconfig.local
```

### Adding New Aliases
Add custom aliases to your local configuration:
```bash
# Add to ~/.gitconfig.local
[alias]
    myalias = !my command
    custom-log = log --oneline --grep="custom"
```

### Adding New Ignore Patterns
Add custom ignore patterns to your local gitignore:
```bash
# Add to ~/.gitignore_global
# Custom patterns
*.custom
custom/
```

## Tips

1. **Use aliases**: Learn the aliases to speed up your Git workflow
2. **Commit messages**: Use conventional commit format (feat:, fix:, docs:, etc.)
3. **Branch naming**: Use descriptive branch names (feature/user-auth, bugfix/login-error)
4. **Keep it clean**: Use `git clean` and `git reset` to clean up your working directory
5. **Use hooks**: Set up pre-commit hooks for code quality

## Troubleshooting

### Common Issues

1. **Aliases not working**: Check that the alias is defined correctly
2. **Global gitignore not working**: Ensure `core.excludesfile` is set
3. **Editor not opening**: Check that the editor is installed and in PATH

### Debug Commands
```bash
# Check git configuration
git config --list

# Check specific setting
git config user.name
git config user.email

# Check global gitignore
git config core.excludesfile

# Test alias
git alias-name
```

## Contributing

When adding new configurations:
1. Test aliases with common Git operations
2. Add documentation for new aliases
3. Keep ignore patterns practical and commonly used
4. Consider cross-platform compatibility
5. Add to appropriate README sections
