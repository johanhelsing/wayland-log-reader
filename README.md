# Wayland Log Reader

`wayland-log-reader` reads standard Wayland log output, i.e. when applications
are run with `WAYLAND_DEBUG=1`, and augments it with syntax highlighting,
filtering and analysis.

![Screenshot](https://i.imgur.com/BgwNvkm.png)

## Features

- Per-object color coding and highlighting (it's smart enough to differentiate
  one object named `wl_callback@12` from one with the same name created later.
- wayland-log-reader will just ignore everything it doesn't understand and
  treat it as comments. This means if you are logging from other libraries as
  well, those will still be visible in your log.

## Usage

Open an existing log

    $ wayland-log-reader wayland.log

Or you can read logs from stdin. i.e.

    $ WAYLAND_DEBUG=1 weston-terminal 2>&1 | wayland-log-reader 

Wayland Log Reader will start when stdin closes, typically when you close the window.

## Comparison with similar tools

The point of this tool, as opposed to similar proxying log analyzer tools, is
that it can be run on standard log output, which is useful because it:

- Works on existing logs which may be attached to bug reports etc.
- Doesn't require compiling and running the tool on the target device, just
  grab the log, and do it your desktop computer.

## Dependencies

- QtQuick Controls 2
- Qbs

## Building

In project directory

    $ qbs
