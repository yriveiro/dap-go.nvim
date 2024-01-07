vim.cmd([[set runtimepath+=.]])
vim.cmd([[set rtp+=/nvim/plugins/plenary.nvim]])
vim.cmd([[set rtp+=/nvim/plugins/nvim-dap]])
vim.cmd([[set rtp+=/nvim/plugins/nvim-lspconfig]])

vim.cmd([[runtime! plugin/plenary.vim]])
vim.cmd([[runtime! plugin/nvim-dap.vim]])
vim.cmd([[runtime! plugin/dap-go.vim]])

vim.o.swapfile = false
vim.bo.swapfile = false
