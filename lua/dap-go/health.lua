local fn = vim.fn
local is_win = vim.api.nvim_call_function('has', { 'win32' }) == 1

local health_start = vim.fn['health#report_start']
local health_ok = vim.fn['health#report_ok']
local health_warn = vim.fn['health#report_warn']
local health_error = vim.fn['health#report_error']

local dependencies= {
  {
    debugger = 'Delve',
    package = {
      {
        name = 'dlv',
        binaries = { 'dlv' },
        args = { 'version' },
        url = '[go-delve/delve](https://github.com/go-delve/delve)',
        optional = false,
      },
    },
  },
}

local plugins = {
  { lib = 'plenary', optional = false },
}

local is_installed = function(package)
  local binaries = package.binaries or { package.name }
  local args = package.args or {}

  for _, binary in ipairs(binaries) do
    if is_win then
      binary = binary .. '.exe'
    end
    print(vim.inspect(binary .. ' ' .. table.concat(args, ' ')))
    if fn.executable(binary) == 1 then
      local handle = io.popen(binary .. ' ' .. table.concat(args, ' '))
      local version = handle:read '*a'
      handle:close()
      return true, version
    end
  end
end

local function lualib_installed(lib_name)
  local res, _ = pcall(require, lib_name)
  return res
end

local health = {}

health.check = function()
  -- Required lua libs
  health_start 'Checking for required plugins'
  for _, plugin in ipairs(plugins) do
    if lualib_installed(plugin.lib) then
      health_ok(plugin.lib .. ' installed.')
    else
      local lib_not_installed = plugin.lib .. ' not found.'
      if plugin.optional then
        health_warn(('%s %s'):format(lib_not_installed, plugin.info))
      else
        health_error(lib_not_installed)
      end
    end
  end

  -- external dependencies
  health_start 'Checking external dependencies'

  for _, dep in pairs(dependencies) do
    for _, package in ipairs(dep.package) do
      local ok, version = is_installed(package)
      if not ok then
        local err_msg = ('%s: not found.'):format(package.name)
        if package.optional then
          health_warn(('%s %s'):format(err_msg, ('Install %s for extended capabilities'):format(package.url)))
        else
          health_error(
            ('%s %s'):format(
              err_msg,
              ('`%s` debug will not function without %s installed.'):format(dep.debugger, package.url)
            )
          )
        end
      else
        local eol = version:find '\n'
        health_ok(('%s: found %s'):format(package.name, version:sub(0, eol - 1) or '(unknown version)'))
      end
    end
  end
end

return health
