# mlem
A minimal [lemonbar](https://github.com/lemonboy/bar) manager
written entirely in a few lines of POSIX shell script.


## Concept
At its core `mlem` works by reading lines formatted `name:value` from a [fifo](https://linux.die.net/man/4/fifo)
and storing the `value` in `$b_name`

After every received line
it runs the `format_line` function defined in the config
and pipes its output to lemonbar.

This way it can idle until the data on the bar actually needs to be changed,
consuming very little system resources,
as well as being less prone to slowdowns caused by a single poorly optimized module.

The fifo can either be written to from background processes spawned by `mlem`
or an external program or script, for example your crontab.


## Configuration
In compliance with the XDG Base Directory Specification
`mlem` will read its configuration file from `$XDG_CONFIG_HOME/mlem/config`.
This is also the recommended directory for the background scripts launched by `mlem`,
though that is not a requirement.

The main `config` file is a shell script,
sourced by `mlem` on startup and every update.
It must contain at least the following:
- the variable `lemonbar_options`,
	which contains the launch flags for lemonbar.
- the function `init_modules`,
	which is executed by `mlem` once on launch
	and should be used to fork your background scripts.
- the function `format_line`,
	which is executed after every update received on the fifo
	and should as such be written as lightweight as possible.
	It must return a string which can be interpreted by lemonbar.

The module scripts launched by `mlem` via `init_modules`
will have access to the location of the fifo
via the `$pipe` variable.

Anything writing to the fifo must use the formatting of `name:value\n`,
where `name` may only contain characters which can be the name of a variable
and `value` can be any string (not containing newlines)
and will be stored in `$b_name` for use in `format_line`.

You can install an example configuration using `make config`.
it includes:
- the current date and time
- pusleaudio default sink and source volume
- your ping to 8.8.8.8
- the i3wm workspace (disabled by default, more info in config)


## Installation

mlem itself has no additional dependencies besides lemonbar,
but some of the example modules go beyond the coreutils.
Their dependencies are documented at the top of their scripts.

`make install`
will create a symlink to `mlem` in `~/.local/bin/`.

Alternatively you can also place it somewhere in in your PATH yourself
or just run it directly from here.

`make uninstall`
will simply delete `~/.local/bin/mlem`.
