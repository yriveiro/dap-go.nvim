test:
	@printf "\nRunning tests\n"
	@docker run -it --rm local/nvim-dap:latest sh ./scripts/run_tests.sh

lint:
	@printf "\nRunning luacheck\n"
	luacheck lua/* tests/*

docgen:
	nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "luafile ./scripts/gendocs.lua" -c 'qa'

build:
	@docker buildx build -t local/nvim-dap .

.PHONY: test lint docgen build
