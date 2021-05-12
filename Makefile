install:
	ln -sf "$(shell pwd)/mlem" "${HOME}/.local/bin/mlem"

uninstall:
	rm "${HOME}/.local/bin/mlem"

config:
	# make sure we don't break anything
	[ -n "${XDG_CONFIG_HOME}" ]
	# create the configuration directory
	mkdir "${XDG_CONFIG_HOME}/mlem"
	# copy the example configuration
	cp example_config "${XDG_CONFIG_HOME}/mlem/config"
	cp example_modules/volume "${XDG_CONFIG_HOME}/mlem/volume"
	cp example_modules/ping "${XDG_CONFIG_HOME}/mlem/ping"
	cp example_modules/i3workspace "${XDG_CONFIG_HOME}/mlem/i3workspace"
