# Neovim Configuration

A modern Neovim configuration built with Lua and managed by Lazy.nvim.

## Prerequisites

### 1. Neovim 0.12+

`nvim-treesitter` is on the rewritten `main` branch, which needs Neovim 0.12 or newer. This config is tested on the 0.13 nightly from the Ubuntu PPA.

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

Alternatively, install a GitHub nightly:

```bash
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64 /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
```

Confirm with `nvim --version`.

### 2. Build tools

Several plugins compile native code on first install:

| Dependency | Used by |
| --- | --- |
| `gcc` / `clang` | Treesitter parsers, telescope-fzf-native |
| `make` | telescope-fzf-native (`make`), LuaSnip (`make install_jsregexp`) |
| `curl`, `tar`, `git` | lazy.nvim and treesitter parser downloads |

```bash
sudo apt install build-essential git curl tar
```

`gcc` alone is not enough for telescope-fzf-native. Its lazy build step is `make`, so install that package if it is missing.

### 3. tree-sitter CLI 0.26.1+

The `main` treesitter plugin shells out to `tree-sitter` to compile parsers. Ubuntu's `apt` package is currently too old (0.25.x). Install the official binary into `~/.local/bin` (this config prepends that directory to `PATH`):

```bash
mkdir -p ~/.local/bin
TAG=$(curl -fsSL https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
curl -fsSL -o /tmp/tree-sitter.gz "https://github.com/tree-sitter/tree-sitter/releases/download/${TAG}/tree-sitter-linux-x64.gz"
gzip -dc /tmp/tree-sitter.gz > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
tree-sitter --version   # expect 0.26.1 or newer
```

Neovim 0.13 uses the `vimdoc` parser for `:help` and `:helptags`. This config installs `vim`, `vimdoc`, and `query` on startup. If those parsers are missing you will see `No parser for language "vimdoc"`.

### 4. ripgrep

Telescope live grep (`<leader>fg`) needs `rg` on your `PATH`:

```bash
sudo apt install ripgrep
```

### 5. Nerd Font

This configuration uses Nerd Font icons for Airline, NERDTree, and Telescope.

**Recommended font: 0xProto**

```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip
unzip 0xProto.zip
sudo mkdir -p /usr/local/share/fonts/0xProto
sudo mv *.ttf /usr/local/share/fonts/0xProto/
sudo fc-cache -fv
```

Then set your terminal font to 0xProto.

### 6. Language runtimes (Mason LSPs)

Mason installs language servers, but some servers still need a toolchain on the machine:

| Runtime | Servers in this config |
| --- | --- |
| Node.js (LTS) | `ts_ls`, `html`, `tailwindcss`, `svelte` |
| Rust (`rustup`) | `rust_analyzer` |
| Go | `gopls` |
| (none extra) | `lua_ls` is a Mason binary |

Node via NVM:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install --lts
nvm use --lts
```

Skip Go or Rust until you need those languages. Mason will fail on `gopls` if `go` is not installed; that is expected.

### 7. Optional: WakaTime

`vim-wakatime` is enabled at startup. If you use it, add your API key so it can write `~/.wakatime.cfg`. Otherwise you can ignore the config-file warning or remove `lua/logan/plugins/wakatime.lua`.

## Installation

1. **Clone this configuration:**

   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

2. **Start Neovim:**

   ```bash
   nvim
   ```

   Lazy.nvim installs plugins on first launch. Treesitter will then compile parsers in the background (needs `gcc` and `tree-sitter`).

3. **Restart Neovim** after the first plugin install.

4. **Sanity checks:**

   ```
   :checkhealth
   :checkhealth nvim-treesitter
   :TSInstallInfo
   ```

   Confirm `vimdoc` is installed and `telescope-fzf-native` built `build/libfzf.so`. If the fzf library is missing:

   ```bash
   cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
   make
   ```

Do not run Neovim as root. Plugin and parser directories under `~/.local/share/nvim` must be owned by your user.

## Windows and Neovide

Neovim reads this config from `%LOCALAPPDATA%\nvim`, and plugins and parsers live in `%LOCALAPPDATA%\nvim-data` instead of `~/.local/share/nvim`.

```powershell
git clone <your-repo-url> $env:LOCALAPPDATA\nvim
```

Install the tools with Scoop (Neovim nightly is not published to winget):

```powershell
scoop bucket add main; scoop bucket add extras; scoop bucket add versions; scoop bucket add nerd-fonts
scoop install git ripgrep nodejs-lts 7zip cmake tree-sitter neovim-nightly neovide 0xProto-NF
```

Install the Visual Studio Build Tools with the C++ workload. CMake and the tree-sitter CLI both locate MSVC on their own, so you do not need a Developer prompt:

```powershell
winget install Microsoft.VisualStudio.2022.BuildTools --override "--wait --passive --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
```

Then start Neovide, let lazy.nvim install plugins, restart, and run `:checkhealth nvim-treesitter` and `:checkhealth mason`.

Windows notes:

- GNU `make` is not part of MSVC. On Windows telescope-fzf-native builds with CMake instead, and LuaSnip skips the optional `jsregexp` build when `make` is missing. If you would rather use `make`, run `scoop install make gcc` and both original build steps work.
- The fzf library is `build\libfzf.dll`. Rebuild it with `:Lazy build telescope-fzf-native.nvim`.
- Mason needs PowerShell, git, tar and 7-Zip. Windows 10 and later ship `tar.exe` and `curl.exe` in System32, which is why `lua/logan/lazy.lua` must join `PATH` with `;` on Windows.
- WakaTime downloads `wakatime-cli.exe` by itself and keeps its key in `%USERPROFILE%\.wakatime.cfg`.

Neovide notes (`vim.g.neovide` is true only inside Neovide):

- The GUI font is set to `0xProto Nerd Font` in `lua/logan/core/options.lua`; change the `:h12` suffix to resize.
- smear-cursor is disabled because Neovide animates its own cursor.
- nightfly transparency is turned off because there is no terminal to show through. Use `vim.g.neovide_opacity` if you want a translucent window.
- Neovide delivers Ctrl+/ as `<C-/>` while terminals send `<C-_>`; the comment toggle is bound to both.

## Configuration Structure

- `init.lua` - Main entry point
- `lua/logan/core/` - Core Neovim settings (options, keymaps)
- `lua/logan/plugins/` - Plugin configurations
- `lua/logan/lazy.lua` - Lazy.nvim bootstrap and startup guards
- `lazy-lock.json` - Pinned plugin commits

## Features

- **Plugin Management**: Lazy.nvim
- **LSP**: Mason + nvim-lspconfig (`vim.lsp.config` / `automatic_enable`)
- **File Explorer**: NERDTree
- **Fuzzy Finder**: Telescope + fzf-native
- **Syntax Highlighting**: nvim-treesitter (`main` branch)
- **Auto-completion**: nvim-cmp + LuaSnip
- **Status Line**: Airline
- **Commenting**: Comment.nvim + ts-context-commentstring

## Troubleshooting

1. **`No parser for language "vimdoc"`**
   - Neovim 0.13 generates helptags with Treesitter.
   - Install `tree-sitter` 0.26.1+ on `PATH`, then `:TSInstall vimdoc vim query lua`.
   - `lua/logan/lazy.lua` pcall-wraps lazy's helptags so a missing parser warns instead of aborting startup.

2. **Telescope: `'fzf' extension doesn't exist` / missing `libfzf.so` (`libfzf.dll` on Windows)**
   - You need both `gcc` and `make` (on Windows: `cmake` and the Visual Studio Build Tools).
   - Rebuild with `make` in `~/.local/share/nvim/lazy/telescope-fzf-native.nvim`, or `:Lazy build telescope-fzf-native.nvim` from inside Neovim.
   - Telescope config pcall-loads the extension so a failed compile does not crash Neovim.

3. **Mason failed on `gopls` / `rust_analyzer` / `ts_ls`**
   - Install the matching runtime (Go, Rust, Node) or remove that server from `ensure_installed` in `lua/logan/plugins/lsp/mason.lua`.

4. **Permission denied under `~/.local/share/nvim`**
   - The data dir was probably created as root.
   - `sudo chown -R "$USER:$USER" ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim`

5. **Check versions:**

   ```bash
   nvim --version
   tree-sitter --version
   node --version
   rg --version
   gcc --version
   make --version
   ```

6. **Reinstall plugins:**

   ```bash
   rm -rf ~/.local/share/nvim/lazy
   nvim
   ```

## Getting Help

- [Neovim documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-treesitter (main)](https://github.com/nvim-treesitter/nvim-treesitter)
- Individual plugin docs for everything else
