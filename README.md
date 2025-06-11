# 🛠️ Dotfiles Managed by chezmoi

This repository contains my personal dotfiles, managed using [chezmoi](https://www.chezmoi.io/) to ensure a consistent and secure developer environment across machines. It includes configurations for tools like Neovim, Ghostty, and Starship, along with automated setup scripts for a complete cloud/DevOps-focused development environment.

## 🚀 Getting Started

To set up this environment on a new machine:

1. **Install chezmoi**

   ```bash
   brew install chezmoi
   ```

2. **Initialize chezmoi**

   Start by cloning this repo using chezmoi:

   ```bash
   chezmoi init https://github.com/<USERNAME>/dotfiles
   ```

3. **Configure personal values**

   Edit the config file:

   ```bash
   chezmoi edit-config
   ```

   Below is the structure (YAML) of the configuration, these fields are required:

   ```yaml
   data:
      type: personal # set to either `work` or `personal` to tailor the installation
      hostname: my-hostname
      git: # Used for ~/.gitconfig
         email: <name@email.com>
         name: <First Last>
         signingKey: 1234ABC567DEF
   ```

   You can also configure default behaviors (edit, Git, etc.) as so:

   ```yaml
   edit:
      command: nvim

   git:
      autoCommit: true
      autoPush: true
   ```

   For more information please see the official [Chezmoi docs](https://www.chezmoi.io/reference/).

4. **Apply the configuration and initialize shell environment**

   ```bash
   chezmoi apply
   ```

   > 🔧 The `chezmoi apply` command applies all the dotfiles from the repository, runs automated setup scripts from `.chezmoiscripts/`, installs packages defined in `.chezmoidata/`, sets up your shell environment, and configures system defaults. It's the one-stop bootstrap script for your setup.

## 📁 Repository Structure

- **`dot_config/`**: Application configurations (Neovim, Ghostty, Starship, etc.)
- **`.chezmoiscripts/`**: Automated setup scripts that run during `chezmoi apply`
  - Package installation (Homebrew, Krew, pipx)
  - System defaults configuration
  - Development environment setup (oh-my-zsh, k3d, atuin, etc.)
- **`.chezmoidata/`**: Configuration data files
  - `packages.yaml`: Homebrew taps, formulas, casks, and VS Code extensions
  - `krew.yaml`: kubectl plugins with architecture support
  - `helm.yaml`: Helm repositories and plugins
- **`private_dot_*`**: Files with restricted permissions (GPG, SSH keys, API keys, login credentials, etc.)

## 🔐 Sensitive Configs & Password Manager Integration

Certain files, such as `.aws/config`, are managed via 1Password or Bitwarden and templated using chezmoi's template functions. These secrets are not stored in plaintext or committed to this repo. Ensure that you have the appropriate CLI (`op` for 1Password or `bw` for Bitwarden) installed and authenticated before running `chezmoi apply`.

## 🧼 Environment Classes

You can toggle between `work` and `personal` setups by updating the `type` value in your chezmoi config. This influences:

- Which tools are installed (e.g., `defenseunicorns/tap` for work)
- Git signing keys and credential managers
- Cloud and infra tools included

## 🛠️ Included Tools & Configurations

### Development Environment
- **Shell**: Zsh with Oh-My-Zsh, Starship prompt, zoxide, fzf
- **Editor**: Neovim (Kickstart.nvim with LSP, treesitter, debugging)
- **Terminals**: Ghostty with custom configuration
- **Version Control**: Git with GPG signing, delta for diffs

### Cloud & DevOps Tools
- **Cloud Providers**: AWS CLI, Azure CLI, Google Cloud SDK
- **Kubernetes**: kubectl, k9s, k3d, kind, krew plugins, Helm
- **Infrastructure**: Terraform, Ansible, Packer
- **Containers**: Docker, Podman, Tilt
- **Security**: SOPS, Cosign, Grype

### Modern CLI Replacements
- `bat` → `cat` (with syntax highlighting)
- `eza` → `ls` (with icons and git integration)
- `ripgrep` → `grep` (faster search)
- `fd` → `find` (user-friendly find)
- `zoxide` → `cd` (smarter directory navigation)

---

## 📎 Tips

- **Password Manager Integration**:
  - **1Password**: Ensure `op` CLI is installed and run `eval $(op signin)`
  - **Bitwarden**: Install the [Bitwarden CLI](https://bitwarden.com/help/cli/)
    - `bw login`
    - `bw unlock`
    - `export BW_SESSION=...`
- **Update configs**: Use `chezmoi diff` to preview, `chezmoi edit` to modify, and `chezmoi apply` to apply changes
- **Add new files**: Use `chezmoi add <file>` to start managing a file with chezmoi
- **Debugging**: Run scripts manually from `.chezmoiscripts/` to troubleshoot issues