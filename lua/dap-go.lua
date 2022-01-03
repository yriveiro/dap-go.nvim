local util = require('dap-go.util')
local config = require('dap-go.config')
local env = require('dap-go.env')

local uv = vim.loop
local dap = util.load_module('dap')
local job = util.load_module('plenary.job')

---@class DapGo
local M = {}

local function on_stdout()
  ---@note on_stdout(error: string, data: string, self? Job)
  return function(err, data)
    assert(not err, err)
    if data then
      vim.schedule(function()
        require('dap.repl').append(data)
      end)
    end
  end
end

local function on_exit()
  ---@note on_exit(self, code: number, signal: number)
  return function(_, code)
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end
end

local function on_stderr()
  ---@note on_stderr(error: string, data: string, self? Job)
  return function() end
end

local function setup_adapter()
  dap.adapters.go = function(cb, configuration)
    local host = configuration.host or '127.0.0.1'
    local port = configuration.port or '38697'
    local addr = string.format('%s:%s', host, port)

    if configuration.options.env then
      env.extend(configuration.options.env)
    end

    job
      :new({
        command = 'dlv',
        env = env.current,
        cwd = uv.cwd(),
        args = { 'dap', '-l', addr },
        on_exit = on_exit(),
        on_stdout = on_stdout(),
        on_stderr = on_stderr(),
      })
      :start()

    vim.defer_fn(function()
      cb({ type = 'server', host = host, port = port })
    end, 100)
  end
end

function M.setup(options)
  config.setup(options)

  dap.configurations.go = config.dap.configurations
  setup_adapter()
end

return M
