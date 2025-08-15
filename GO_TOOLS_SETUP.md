# Go Tools Setup for Neovim

## Overview
This document outlines the Go development tools that have been installed and configured for your Neovim setup.

## Installed Go Tools

### Core Language Server and Tools
- **gopls** (v0.20.0) - Official Go Language Server Protocol implementation
- **goimports** - Automatically manages Go imports
- **gofumpt** - Stricter version of gofmt for code formatting

### Linting and Static Analysis
- **gopls** - Primary linting via LSP (built-in, automatic)
- **golangci-lint** - Comprehensive Go linter (manual use via keybindings)
- **staticcheck** - Advanced static analysis tool for Go

### Debugging
- **delve (dlv)** - Go debugger for debugging Go programs

### Code Generation and Refactoring
- **gotests** - Generates Go tests for your functions
- **gomodifytags** - Modifies struct tags in Go code
- **iferr** - Generates `if err != nil` blocks
- **impl** - Generates interface implementations

## Neovim Configuration

### Plugin Configuration
The Go configuration is split between two files:

**`lua/config/lazy.lua`** - Imports LazyVim Go extras in correct order:
- `lazyvim.plugins` (core LazyVim)
- `lazyvim.plugins.extras.lang.go` (Go language support)
- `plugins` (custom configurations)

**`lua/plugins/go.lua`** - Custom Go tool configuration:

1. **Enhanced Tool Installation** - Additional Go tools via Mason
2. **Enhanced LSP Configuration** - Optimized gopls settings with:
   - Code lenses for various Go operations
   - Inlay hints for better code understanding
   - Advanced static analysis
   - Semantic tokens support

3. **Formatter Integration** - Uses goimports and gofumpt for code formatting
4. **Linter Integration** - Primary linting via gopls LSP, manual golangci-lint via keybindings
5. **Treesitter Support** - Syntax highlighting for Go, go.mod, go.work, and go.sum files
6. **Debug Adapter Protocol** - Debugging support via nvim-dap-go
7. **Testing Support** - Integration with neotest for running Go tests

### Key Features Enabled
- **Auto-formatting** on save with goimports and gofumpt
- **Real-time linting** via gopls LSP with manual golangci-lint option
- **Code completion** and navigation via gopls
- **Debugging support** with delve integration
- **Test running** and coverage reporting
- **Code generation** helpers for common Go patterns

## PATH Configuration
Updated `~/.zshrc` to include Go tools in PATH:
```bash
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
```

## Verification
All tools have been tested and are working correctly:
- Go compiler: ✅ (go version go1.24.1 linux/amd64)
- Language server: ✅ (gopls v0.20.0)
- Formatters: ✅ (goimports, gofumpt)
- Linting: ✅ (gopls LSP + manual golangci-lint)
- Debugger: ✅ (delve)

## Usage in Neovim

### Key Bindings (when in Go files)
- `<leader>cR` - Run Go program
- `<leader>ct` - Run Go tests
- `<leader>cT` - Run specific Go test function
- `<leader>cc` - Show Go coverage
- `<leader>cl` - Run golangci-lint on current file (shows results in quickfix)
- `<leader>cL` - Run golangci-lint on entire project

### LSP Features Available
- Go to definition (`gd`)
- Find references (`gr`)
- Hover documentation (`K`)
- Code actions (`<leader>ca`)
- Rename symbol (`<leader>cr`)
- Format document (`<leader>cf`)

### Debugging
- Set breakpoints and debug Go programs using nvim-dap
- Integrated with delve debugger

## Plugin Loading Order
The configuration follows LazyVim's required loading order:
1. `lazyvim.plugins` (core LazyVim plugins)
2. `lazyvim.plugins.extras.lang.go` (Go language extras)
3. `plugins` (custom configurations)

This ensures proper initialization and prevents loading order warnings.

## Next Steps
1. Restart Neovim to load the new Go configuration
2. Open a Go file to test LSP functionality
3. Try the key bindings and features listed above
4. Install any additional Go-specific plugins as needed

## Troubleshooting
If you encounter issues:
1. Ensure `~/go/bin` is in your PATH (restart terminal if needed)
2. Run `:checkhealth` in Neovim to verify LSP setup
3. Check Mason installation status with `:Mason`
4. Verify Go tools are accessible: `which gopls`, `which golangci-lint`, `which revive`

### Linting Approach
The configuration now uses a more reliable approach:
1. **Primary linting** via gopls LSP (automatic, real-time)
2. **Manual comprehensive linting** via golangci-lint keybindings
3. **No external linter dependencies** that can cause "not found" errors
4. **Built-in diagnostics** from gopls cover most common issues

### Manual Linting
You can run comprehensive linting manually:
- `<leader>cl` in Neovim - Run golangci-lint on current file
- `<leader>cL` in Neovim - Run golangci-lint on entire project
- `golangci-lint run filename.go` - From terminal
