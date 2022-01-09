---@tag dap-go.nvim
local util = require('dap-go.util')
local config = require('dap-go.config')
local env = require('dap-go.env')

local uv = vim.loop
local dap = util.load_module('dap')
local job = util.load_module('plenary.job')

---@brief [[
--- dap-go.nvim is an extension for `nvim-dap` plugin that configures the usage
--- of Golang debugging over Delve.
---
--- Getting started with dap-go:
---   1. Run `:checkhealth dap-go` to make sure everything is installed.
---   2. Put a `require("dap-go").setup() call somewhere in your neovim config.
---   3. Read |dap-go.setup| to check what config keys are available and what you can put inside the setup call
---   4. Profit
---
--- <pre>
--- To find out more:
--- https://github.com/yriveiro/dap-go.nvim
---
--- :h dap-go.setup
--- </pre>
---@brief ]]

local dapgo = {}

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
        env = env.dump(),
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

--- Setup function to be run by user. Configures the defaults, pickers and
--- extensions of dap-go.
---
--- Usage:
--- <code>
--- require('dap-go').setup({
--- external_config = {
---   --- Enable external config
---   enabled = false,
---   --- File with the config definitions.
---   path = require('dap-go.util').git_root(uv.fs_realpath('.')) .. '/dap-go.json',
--- },
---
--- --- nvim-dap configuration for go.
--- dap = {
---   configurations = {
---     {
---       type = 'go',
---       name = 'Debug',
---       request = 'launch',
---       program = '${file}',
---     },
---     {
---       type = 'go',
---       name = 'Attach',
---       mode = 'local',
---       request = 'attach',
---       processId = require('dap.utils').pick_process,
---     },
---   },
--- },
---})
--- </code>
---@param options table: @Configuration opts. Keys: external_config, dap
function dapgo.setup(options)
  config.setup(options)

  ---@diagnostic disable-next-line: undefined-field
  dap.configurations.go = config.dap.configurations
  setup_adapter()
end

return dapgo
