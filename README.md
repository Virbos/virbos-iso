This repository contains source files for the Virbos live ISO.

It is built using archiso, install it using `pacman -S archiso`.

After that, just run `make` as root in the project's directory.

In case you didn't know, here's a quick list of information
you might need to know about archiso and how to modify how it
builds ISOs:

 - The `pacman.conf` file is the file that will be copied to /etc/pacman.conf in the live ISO
 - `packages.x86_64` is a newline-separated list of packages that will be installed to the live ISO
 - `airootfs` is the initial root filesystem. Put config files here and whatever else you want.
