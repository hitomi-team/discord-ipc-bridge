Discord IPC Bridge
=======================

This program enables other programs which are running under Wine to send Rich
Presence data to a Linux Discord client.

This is simply a proof-of-concept, demonstrating that this is possible, the
code itself is a mish-mash of copy-paste from Microsoft docs and
[linux-discord-rpc.dll](https://github.com/goeo-/discord-rpc/blob/linux-under-wine/src/connection_win.cpp).

The way it works is simply by bridging the gap between Windows named pipes
(`\\.\pipe\discord-ipc-0`) and Unix domain sockets
(`/run/user/{userid}/discord-ipc-0`). Ideally something like this would be
implemented in wine itself, it should be possible to add some sort of "mapped
named pipe" feature where `wineserver` will serve handles to unix sockets
instead pseudo-handles to named pipes, but I don't know how to approach
something like that.

Compiling
=========

    i686-w64-mingw32-gcc -masm=intel -mconsole main.c -o winediscordipcbridge

Usage
=====

Run `make install` to install the bridge as a service that runs automatically.
You can change the wine binary and wineprefix of the installation by setting
the `WINE` and `WINEPREFIX` variables respectively.

For example, to install the bridge under the default Proton 5.0 prefix:

```
make install WINE=~/.steam/root/steamapps/common/Proton\ 5.0/dist/bin/wine \
  WINEPREFIX=~/.steam/root/steamapps/common/Proton\ 5.0/dist/share/default_pfx
```

You can uninstall the service by running `make uninstall`. You must
use the same `WINE` and `WINEPREFIX` variables you used to install it.

Disclaimer
==========

This has only been tested under a 32-bit wineprefix.
