test:
	bash ./scripts/run_tests.sh

lint:
	@printf "\nRunning luacheck\n"
	luacheck lua/* tests/*
	@printf "\nRunning stylua\n"
	stylua --check .

.PHONY: test lint
