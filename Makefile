CC = i686-w64-mingw32-gcc
CFLAGS = -O2 -Wall

WINE ?= wine
WINEPREFIX ?= $$HOME/.wine

override _REGKEY = \
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices

all: winediscordipcbridge.exe

winediscordipcbridge.exe: main.c
	$(CC) -masm=intel -mconsole -o $@ $(CFLAGS) $<

clean:
	@rm -v winediscordipcbridge.exe

install: winediscordipcbridge.exe
	@cp -v $< '$(WINEPREFIX)/drive_c/windows/$<'
	@"$(WINE)" reg add '$(_REGKEY)' /v winediscordipcbridge /d 'C:\windows\$<' /f

uninstall:
	@rm -fv '$(WINEPREFIX)/drive_c/windows/winediscordipcbridge.exe'
	@"$(WINE)" reg delete '$(_REGKEY)' /v winediscordipcbridge /f
