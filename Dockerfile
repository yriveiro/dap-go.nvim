FROM alpine:3

WORKDIR /nvim

RUN <<EOF
  \apk --no-cache update
  \apk add --no-cache neovim=0.9.4-r0 git=2.43.0-r0 make=4.4.1-r2

  \git clone --depth 1 https://github.com/nvim-lua/plenary.nvim /nvim/plugins/plenary.nvim
  \git clone --depth 1 https://github.com/tjdevries/tree-sitter-lua /nvim/plugins/tree-sitter-lua
  \git clone --depth 1 https://github.com/neovim/nvim-lspconfig /nvim/plugins/nvim-lspconfig
  \git clone --depth 1 https://github.com/mfussenegger/nvim-dap /nvim/plugins/nvim-dap
EOF

WORKDIR /nvim-dap

COPY --chmod=775 . .
