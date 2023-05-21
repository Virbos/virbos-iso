MKARCHISO      = mkarchiso
MKARCHISOFLAGS = -Avirbos -Cpacman.conf -Lvirbosiso -v -wiso .

CONFREPO = https://github.com/Virbos/virbos-configs
CONFIGS  = alacritty,bspwm,i3,i3status
CONFDIR  = airootfs/home/liveuser/.config

all: virbos-*.*.*-x86_64.iso

virbos-*.*.*-x86_64.iso:
	@# Download configs
	rm -rf airootfs/home/liveuser/.config
	mkdir -p tmp
	mkdir -p ${CONFDIR}
	git clone -q ${CONFREPO} tmp/configs
	cp -R tmp/configs/{${CONFIGS}} ${CONFDIR}
	@# Build ISO
	${MKARCHISO} ${MKARCHISOFLAGS}
	mv out/virbos-*.*.*-x86_64.iso .

clean:
	rm -rf iso out tmp virbos-*.*.*-x86_64.iso airootfs/home/liveuser/.config

.PHONY: all clean
