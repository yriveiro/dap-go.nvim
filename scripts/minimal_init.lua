vim.cmd([[set runtimepath+=.]])
vim.cmd([[set rtp+=~/.local/share/nvim/site/pack/vendor/star/plenary.nvim/]])
vim.cmd([[set rtp+=~/.local/share/nvim/site/pack/vendor/star/nvim-dap]])
vim.cmd([[set rtp+=~/.local/share/nvim/site/pack/vendor/star/nvim-lspconfig]])

vim.cmd([[runtime! plugin/plenary.vim]])
vim.cmd([[runtime! plugin/nvim-dap.vim]])
vim.cmd([[runtime! plugin/dap-go.vim]])

vim.o.swapfile = false
vim.bo.swapfile = false
