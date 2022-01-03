local with = require('plenary.context_manager').with
local open = require('plenary.context_manager').open
local uv = vim.loop

local M = {}

--- @class Options
--- @type table <string, any>
local defaults = {
  external_config = {
    enabled = false,
    path = require('dap-go.util').git_root(uv.fs_realpath('.')) .. '/dap-go.json',
  },
  dap = {
    configurations = {
      {
        type = 'go',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
      },
      {
        type = 'go',
        name = 'Attach',
        mode = 'local',
        request = 'attach',
        processId = require('dap.utils').pick_process,
      },
    },
  },
}

--- @type Options
M._options = {}

--- Load configurations from file and merge it with current ones.
local function load_dap_configurations_from_file()
  local result = with(open(M.external_config.path), function(f)
    return f:read('*all')
  end)

  if result then
    local c = vim.fn.json_decode(result)
    for _, v in pairs(c) do
      table.insert(M.dap.configurations, v)
    end
  end
end

--- @param options table Custom config to set.
--- @return Options
function M.setup(options)
  M._options = vim.tbl_deep_extend('force', {}, defaults, options or {})

  if M.external_config.enabled then
    load_dap_configurations_from_file()
  end
end

local mt = {}
function mt:__index(k)
  return M._options[k]
end

return setmetatable(M, mt)
