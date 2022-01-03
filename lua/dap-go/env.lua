local M = {}

---@class Environment
M._env = vim.fn.environ()

--- Extends the current enviroment with new data.
---@param t table Table with new enviroment variables.
function M.extend(t)
  assert(type(t) == 'table', 'input must be a table')
  for k, v in pairs(t) do
    M._env[k] = v
  end
end

--- Dumps the content of the class.
---@return Environment
function M.dump()
  return M._env
end

local mt = {}
function mt:__index(k)
  return M._env[k]
end

function mt:__newindex(k, v)
  M._env[k] = v
end

return setmetatable(M, mt)
