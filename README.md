This repository contains source files for the Virbos live ISO.

It is built using archiso, install it using `pacman -S archiso`.

After that, just run `make` as root in the project's directory.

In case you didn't know, here's a quick list of information
you might need to know about archiso and how to modify how it
builds ISOs:

 - `pacman.conf` is the file that will be used as the pacman configuration file during the build process
 - `packages.x86_64` is a newline-separated list of packages that will be installed to the live ISO
 - `airootfs` is the initial root filesystem. Put config files here and whatever else you want.

After you've built it, you can test it in QEMU by running
`run_archiso -i virbos-*.iso`.

The default password for liveuser is `virbos`.
Access the root account by using sudo.

For more information on archiso and how to use it, refer to
the [Arch Wiki page](https://wiki.archlinux.org/title/archiso).
