local uv = vim.loop

local fixture_dir = uv.fs_realpath('.') .. '/tests/fixtures'

describe('config', function()
  local config = require('dap-go.config')

  describe('setup', function()
    it('should have external config disabled', function()
      config.setup()
      assert.is_false(config.external_config.enabled)
    end)

    it('should have external config loading enabled', function()
      config.setup({
        external_config = {
          enabled = true,
          path = fixture_dir .. '/dap-go.json',
        },
      })
      assert.is_true(config.external_config.enabled)
    end)
  end)
end)
