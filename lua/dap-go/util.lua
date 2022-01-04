---@tag dap-go.util

---@brief [[
--- Provides common utility function.
---@brief ]]
--
--- @class Util
local M = {}

--- Load a module or fail if the module doesn't exists
---@param mname string: The name of the module
---@return table The module.
function M.load_module(mname)
  local ok, module = pcall(require, mname)
  assert(ok, string.format('dap-go dependency error: %s not installed', mname))
  return module
end

---@param fname string: The name of the current file
---@return string: The path of the git root
---@return string: The git root of fname file
function M.git_root(fname)
  return require('lspconfig.util').root_pattern('.git')(fname)
end

--- Encodes to JSON.
---@note borrowed from https://github.com/tjdevries/tree-sitter-lua/blob/master/lua/nlsp/rpc.lua
---@param data table: Data to encode
---@returns string: Encoded object
function M.json_encode(data)
  local status, result = pcall(vim.fn.json_encode, data)
  if status then
    return true, result
  else
    return nil, result
  end
end

--- Decodes from JSON.
---@param data string: Data to decode
---@returns table: Decoded JSON object
function M.json_decode(data)
  local status, result = pcall(vim.fn.json_decode, data)
  if status then
    return true, result
  else
    return nil, result
  end
end
return M
