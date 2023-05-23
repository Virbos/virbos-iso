MKARCHISO      = mkarchiso
MKARCHISOFLAGS = -Avirbos -Cpacman.conf -LVIRBOS_ISO -wiso .

CONFREPO = https://github.com/Virbos/virbos-configs
CONFIGS  = alacritty,bspwm,i3,i3status
CONFDIR  = airootfs/home/liveuser/.config

ISO   = virbos-$(shell date '+%Y.%m.%d')-x86_64.iso
CKSUM = ${ISO}.sha256

all: ${ISO} ${CKSUM}

${ISO}:
	@# Download configs
	rm -rf airootfs/home/liveuser/.config
	mkdir -p tmp
	mkdir -p ${CONFDIR}
	git clone -q ${CONFREPO} tmp/configs
	cp -Rf tmp/configs/{${CONFIGS}} ${CONFDIR}
	cp -f pacman.conf airootfs/etc/pacman.conf
	@# Build ISO
	${MKARCHISO} ${MKARCHISOFLAGS}
	mv out/virbos-*.*.*-x86_64.iso .

checksum: ${CKSUM}
${CKSUM}: ${ISO}
	@# Generate checksum
	cksum -a sha256 ${ISO} >${CKSUM}

clean:
	rm -rf ${ISO} ${CKSUM} iso out tmp airootfs/{home/liveuser/.config,etc/pacman.conf}

.PHONY: all checksum clean
