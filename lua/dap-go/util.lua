--- @class Util
local M = {}

--- Load a module or fail if the module doesn't exists.
--- @param mname string The name of the module
--- @return table The module.
function M.load_module(mname)
  local ok, module = pcall(require, mname)
  assert(ok, string.format('dap-go dependency error: %s not installed', mname))
  return module
end

--- Return git root of fname file
--- @param fname string The name of the current file.
--- @return string The path of the git root.
function M.git_root(fname)
  return require('lspconfig.util').root_pattern('.git')(fname)
end

return M
