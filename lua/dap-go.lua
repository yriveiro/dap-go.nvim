local util = require 'dap-go.util'
local settings = require 'dap-go.settings'

local M = {}

M.settings = settings.set

local function setup_adapter()
  --local dap = util.load_module('dap')
  --local plenary = util.load_module('plenary')

  --dap.adapters.go = function(cb, configurations)
    --local host = configurations.host or "127.0.0.1"
    --local port = configurations.port or "38697"
    --local addr = string.format("%s:%s", host, port)

    --if configurations.options.env then
      --local _global_env = vim.fn.environ()
      --print(vim.inspect(_global_env))
      --env = vim.tbl_extend("keep", configurations.options.env, _global_env)
    --end

    --plenary.job.Job:new({
      --command = 'dlv',
      --env = env,
      --cwd = vim.loop.cwd(),
      --args = vim.tbl_flatten{"dap", "-l", addr, configurations.args or {}},
      --on_exit = function(_, code)
        --if code ~=0 then
          --print('dlv exited with code', code)
        --end
      --end,
      --on_stdout =function(err, data)
        --assert(not err, err)

        --if data then
          --vim.schedule(function() require('dap.repl').append(data) end)
        --end
      --end,
      --on_stderr =function(err, data)
        --assert(not err, err)

        --if data then
          --vim.schedul(function() require('dap.repl').append(data) end)
        --end
      --end,
    --}):start()

    --vim.defer_fn(function()
      --cb({type = "server", host = "127.0.0.1", port = port})
    --end, 100)
  --end
end

local function setup_configuration(dap)
  dap.configurations.go = M.settings.configurations
end

function M.setup(opts)
  print('hola')
  M.settings(opts)

  util.parse_custom_configurations(vim.loop.fs_realpath('.'))

  setup_adapter()
  setup_configuration()
end

return M
