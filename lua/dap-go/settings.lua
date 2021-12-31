local util = require 'dap-go.util'

local M = {}

---@class DapGoSettings
local DEFAULT_SETTINGS = {
  config_file = 'dap-go.json',
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
      processId = require'dap.utils'.pick_process,
    },
  }
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts DapGoSettings
function M.set(opts)
    M.current = vim.tbl_deep_extend('force', M.current, opts)
end

return M
