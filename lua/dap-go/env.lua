local M = {}

---@class Environment
M._env = vim.fn.environ()
M.extend = function(t)
  assert(type(t) == 'table', 'input must be a table')
  for k, v in pairs(t) do
    M._env[k] = v
  end
end

local mt = {}
function mt:__index(k)
  return M._env[k]
end

function mt:__newindex(k, v)
  M._env[k] = v
end

return setmetatable(M, mt)
