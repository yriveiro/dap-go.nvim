test:
	bash ./scripts/run_tests.sh

lint:
	@printf "\nRunning luacheck\n"
	luacheck lua/* tests/*

docgen:
	nvim --headless --noplugin -u ./scripts/minimal_init.vim -c "luafile ./scripts/gendocs.lua" -c 'qa'

.PHONY: test lint docgen
