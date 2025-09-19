# Neovim Configuration

A modern Neovim configuration built with Lua and managed by Lazy.nvim.

## Prerequisites

Before setting up this configuration, ensure you have the following installed:

### 1. Neovim 0.10+

This configuration requires Neovim version 0.10 or higher. Install it using the official GitHub repository:

```bash
# Add the Neovim repository
sudo add-apt-repository ppa:neovim-ppa/unstable

# Update package list
sudo apt update

# Install Neovim
sudo apt install neovim
```

Alternatively, you can install from the GitHub releases:
```bash
# Download and install the latest release
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /opt/nvim
sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
```

### 2. Nerd Font

This configuration uses Nerd Font icons for the UI. Install a Nerd Font for the best experience:

**Recommended Font: 0xProto**
```bash
# Download the font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip

# Extract and install
unzip 0xProto.zip
sudo mkdir -p /usr/local/share/fonts/0xProto
sudo mv *.ttf /usr/local/share/fonts/0xProto/
sudo fc-cache -fv
```

After installation, configure your terminal to use the 0xProto font.

### 3. Node.js (via NVM)

Many plugins require Node.js. Install it using NVM (Node Version Manager):

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload your shell
source ~/.bashrc

# Install the latest LTS Node.js
nvm install --lts
nvm use --lts
```

## Installation

1. **Clone or copy this configuration:**
   ```bash
   # If using git
   git clone <your-repo-url> ~/.config/nvim
   
   # Or manually copy the files to ~/.config/nvim/
   ```

2. **Start Neovim:**
   ```bash
   nvim
   ```

3. **Install plugins:**
   When you first start Neovim, Lazy.nvim will automatically install all configured plugins. This may take a few minutes.

4. **Restart Neovim:**
   After the initial plugin installation, restart Neovim to ensure everything loads correctly.

## Configuration Structure

- `init.lua` - Main entry point
- `lua/logan/core/` - Core Neovim settings (options, keymaps)
- `lua/logan/plugins/` - Plugin configurations
- `lua/logan/lazy.lua` - Lazy.nvim configuration

## Features

This configuration includes:
- **Plugin Management**: Lazy.nvim for fast, lazy-loaded plugins
- **LSP**: Language Server Protocol support with Mason
- **File Explorer**: NERDTree integration
- **Fuzzy Finder**: Telescope for file and content search
- **Syntax Highlighting**: Tree-sitter for enhanced syntax
- **Auto-completion**: nvim-cmp with LSP integration
- **Status Line**: Airline for a modern status bar
- **Commenting**: Comment.nvim for easy code commenting

## Troubleshooting

If you encounter issues:

1. **Check Neovim version:**
   ```bash
   nvim --version
   ```
   Ensure it's 0.10 or higher.

2. **Verify Node.js installation:**
   ```bash
   node --version
   npm --version
   ```

3. **Check font installation:**
   ```bash
   fc-list | grep -i "0xproto"
   ```

4. **Clear plugin cache:**
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   ```
   Then restart Neovim to reinstall plugins.

## Getting Help

- Check the [Neovim documentation](https://neovim.io/doc/)
- Visit the [Lazy.nvim documentation](https://github.com/folke/lazy.nvim)
- Review individual plugin documentation for specific features