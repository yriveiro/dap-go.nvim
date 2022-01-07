describe('env', function()
  local env = require('dap-go.env')

  describe('instanciate', function()
    it('should load current system enviroment', function()
      assert.not_nil(env.PATH)
    end)
  end)

  describe('current environment', function()
    it('should have system path', function()
      assert.is_string(env.PATH)
    end)
  end)

  describe('extend environment', function()
    it('should have system path', function()
      env['foo'] = 'bar'
      assert.same.equal('bar', env.foo)
    end)

    it('should have custom env vars', function()
      local _env = {
        FOO_VAR_EXTENDED = 'bar',
      }

      env.extend(_env)
      assert.same.equal('bar', env.FOO_VAR_EXTENDED)
    end)
  end)
end)
