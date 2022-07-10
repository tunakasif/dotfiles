# Additional Details

## LSP Install

Language servers are not installed automatically, therefore one needs to download the servers from `:LspInstallInfo`. Some necessary language servers are listed below (list may be outdated).

- pyright
- clangd
- eslint
- html
- pyright
- rust_analyzer
- sumneko_lua
- texlab

## Troubleshoot

Compilation of `tree-sitter-norg` was problematic, so related aspect of the `norg` component is commented out in the following file:

```
~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/lua/nvim-treesitter/parsers.lua
```
