local docgen = require('docgen')

local docs = {}

docs.test = function()
  local input_files = {
    './lua/dap-go.lua',
    './lua/dap-go/config.lua',
    './lua/dap-go/env.lua',
    './lua/dap-go/util.lua',
  }

  local output_file = './doc/dap-go.txt'
  local output_file_handle = io.open(output_file, 'w')

  for _, input_file in ipairs(input_files) do
    docgen.write(input_file, output_file_handle)
  end

  if output_file_handle then
    output_file_handle:write(' vim:tw=78:ts=8:ft=help:norl:\n')
    output_file_handle:close()
  end

  vim.cmd([[checktime]])
end

docs.test()

return docs
