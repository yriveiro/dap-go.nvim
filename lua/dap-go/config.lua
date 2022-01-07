---@tag dap-go.config
local open = require('plenary.context_manager').open
local with = require('plenary.context_manager').with
local util = require('dap-go.util')
local uv = vim.loop

---@brief [[
--- Config holds all the configuration to operate the extension.
---
---@brief ]]

---@class Config @Expose Configures the |dap-go.nvim| extension
local config = {}

config._options = {}

local mt = {}
function mt:__index(k)
  return config._options[k]
end

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

--- Load configurations from file and merge it with current ones.
---@private
local function load_dap_configurations_from_file()
  local result = with(open(config.external_config.path), function(f)
    return f:read('*all')
  end)

  if result then
    local ok, c = util.json_decode(result)
    if ok then
      for _, v in pairs(c) do
        table.insert(config.dap.configurations, v)
      end
    end
  end
end

--- Setup function, this function is internally called by |dap-go.setup()| and
--- depending on the configuration will load an external config file.
---
--- Usage:
--- <code>
--- require('dap-go').setup{
---  external_config = {
---    --- Enable external config
---    enabled = false,
---    --- File with the config definitions.
---    path = require('dap-go.util').git_root(uv.fs_realpath('.')) .. '/dap-go.json',
---  },
---
---  --- nvim-dap configuration for go.
---  dap = {
---    configurations = {
---      {
---        type = 'go',
---        name = 'Debug',
---        request = 'launch',
---        program = '${file}',
---      },
---      {
---        type = 'go',
---        name = 'Attach',
---        mode = 'local',
---        request = 'attach',
---        processId = require('dap.utils').pick_process,
---      },
---    },
---  },
--- },
--- </code>
---@param options table: Custom options.
function config.setup(options)
  config._options = vim.tbl_deep_extend('force', {}, defaults, options or {})

  if config.external_config.enabled then
    load_dap_configurations_from_file()
  end
end

setmetatable(config, mt)

return config
