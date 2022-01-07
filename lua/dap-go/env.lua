---@brief [[
--- This class wraps the `vim.fn.environ` with some functionalities and
--- validations.
---@brief ]]
---@tag dap-go.env

local _env = vim.fn.environ()

---@class Environment
local env = {}
env._env = _env

local mt = {}
function mt:__index(k)
  return env._env[k]
end

function mt:__newindex(k, v)
  env._env[k] = v
end

--- Extends the current enviroment with new data.
---@param t table: extended enviroment variables to merge with current ones.
function env.extend(t)
  assert(type(t) == 'table', 'input must be a table')
  for k, v in pairs(t) do
    env._env[k] = v
  end
end

--- Dumps the content of the class.
---@return table: Table with all the enviroment
function env.dump()
  return env._env
end

setmetatable(env, mt)

return env
