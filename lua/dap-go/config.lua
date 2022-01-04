local open = require('plenary.context_manager').open
local with = require('plenary.context_manager').with
local util = require('dap-go.util')
local uv = vim.loop

local M = {}

---@class Options
---@type table <string, any>
local defaults = {
  external_config = {
    --- Enable external config
    enabled = false,
    --- File with the config definitions.
    path = require('dap-go.util').git_root(uv.fs_realpath('.')) .. '/dap-go.json',
  },

  --- nvim-dap configuration for go.
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

---@type Options
M._options = {}

--- Load configurations from file and merge it with current ones.
local function load_dap_configurations_from_file()
  local result = with(open(M.external_config.path), function(f)
    return f:read('*all')
  end)

  if result then
    local ok, c = util.json_decode(result)
    if ok then
      for _, v in pairs(c) do
        table.insert(M.dap.configurations, v)
      end
    end
  end
end

---@param options table Custom config to set.
---@return Options
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
