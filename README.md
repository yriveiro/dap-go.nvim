# dap-go.nvim

Golang with Delve over Debug Adapter Protocol for [Neovim](https://neovim.io/) (>= 0.5)

# What is DAP Go

`dap-go.nvim` os an extension for [nvim-dap](https://github.com/mfussenegger/nvim-dap) to configurate Go with Delve debugger.

# Table of Content

- [Features](#features)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Installation](#installation)
- [Contributing](#contributing)
- [Changelog](https://github.com/yriveiro/dap-go.nvim/blob/master/doc/dap_go_changelog.md)
- [Acknowledgement](#Acknowledgement)
- [License](#license)

## Features

* Load `dap` configurations from a file.

## Getting Started

This section should guide you on how to add the extention to `nvim-dap`.

### Dependencies

* [Neovim (v.5.1)](https://github.com/neovim/neovim/releases/tag/v0.5.1) or higher.
* [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) for all the stuff I don't want to write twice.
* [Delve](https://github.com/go-delve/delve)

### Suggested Dependencies

* [telescope-dap](https://github.com/nvim-telescope/telescope-dap.nvim) to browse the `dap` configurations.
* [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) for more user friendly DAP user interface.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'nvim-lua/plenary.nvim'
Plug 'yriveiro/dap-go.nvim'
```

Using [dein](https://github.com/Shougo/dein.vim)

```viml
call dein#add('nvim-lua/plenary.nvim')
call dein#add('yriveiro/dap-go.nvim')
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'yriveiro/dap-go.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
```

## Usage

```lua
require('dap-go').setup()
```

If you want to use a json file to hold configurations for the debugger you need
to enable the external config feature.

```lua
require('dap-go').setup({
  external_config = {
    enable = true,
    path = require('dap-go.util').git_root(uv.fs_realpath('.')) .. '/dap-go.json'
  }
})
```

## Contributing

All contributions are welcome! Just open a pull request. Please read CONTRIBUTING.md

## Acknowledgement

* [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)

## License

Licensed under the MIT License. Check the [LICENSE](https://github.com/yriveiro/dap-go.nvim/blob/main/LICENSE) file for details.
