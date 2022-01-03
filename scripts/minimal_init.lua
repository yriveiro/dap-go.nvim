vim.cmd([[set runtimepath+=.]])
vim.cmd([[set rtp+=~/.config/nvim/plugged/plenary.nvim/]]) -- @yriveiro TODO: change this, look https://github.com/nvim-telescope/telescope.nvim/blob/master/.github/workflows/ci.yml
vim.cmd([[set rtp+=~/.config/nvim/plugged/nvim-dap]]) -- @yriveiro TODO: change this, look https://github.com/nvim-telescope/telescope.nvim/blob/master/.github/workflows/ci.yml
vim.cmd([[set rtp+=~/.config/nvim/plugged/nvim-lspconfig]]) -- @yriveiro TODO: change this, look https://github.com/nvim-telescope/telescope.nvim/blob/master/.github/workflows/ci.yml

vim.cmd([[runtime! plugin/plenary.vim]])
vim.cmd([[runtime! plugin/nvim-dap.vim]])
vim.cmd([[runtime! plugin/dap-go.vim]])
vim.cmd([[runtime! plugin/nvim-lspconfig]])

vim.o.swapfile = false
vim.bo.swapfile = false
