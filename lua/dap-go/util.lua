---@brief [[
--- This class provides common functions used in dap-go extension.
---@brief ]]
---@tag dap-go.util

---@class Util @Collection of utility fuctions.
local util = {}

--- Load a module or fail if the module doesn't exists.
---@param name string: Name of the module.
---@return table The module.
function util.load_module(name)
  local ok, module = pcall(require, name)
  assert(ok, string.format('dap-go dependency error: %s not installed', name))
  return module
end

--- Gets the git root of the project base on a file from it.
---@param name string: Name of the current file to start the search from.
---@return string: Path of the git root.
function util.git_root(name)
  return require('lspconfig.util').root_pattern('.git')(name)
end

--- Encodes string data to JSON.
---@usage
---@note borrowed from https://github.com/tjdevries/tree-sitter-lua/blob/master/lua/nlsp/rpc.lua
---@param data table: Data to encode.
---@return string: Encoded JSON object.
function util.json_encode(data)
  local status, result = pcall(vim.fn.json_encode, data)
  if status then
    return true, result
  else
    return nil, result
  end
end

--- Decodes data from JSON.
---@param data string: Data to decode.
---@return table: Decoded JSON object.
function util.json_decode(data)
  local status, result = pcall(vim.fn.json_decode, data)
  if status then
    return true, result
  else
    return nil, result
  end
end

return util
