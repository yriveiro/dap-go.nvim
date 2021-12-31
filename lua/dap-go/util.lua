local M = {}

function M.load_module(mname)
  local ok, module = pcall(require, mname)
  assert(ok, string.format('dap-go dependency error: %s not installed', mname))
  return module
end

function M.git_root(fname)
  return require('lspconfig.util').root_pattern('.git')(fname)
end


function M.parse_custom_configurations(fname)
  local configurations = {}
  local p = M.git_root(fname)
  local file = io.open(p, 'r')

  if file then
    configurations = vim.fn.json.decode(file:read("*all"))
  end

  return configurations
end

return M
