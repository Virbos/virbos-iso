MKARCHISO      = mkarchiso
MKARCHISOFLAGS = -Avirbos -Cpacman.conf -LVIRBOS_ISO -wiso .

CONFREPO = https://github.com/Virbos/virbos-configs
CONFDIR  = airootfs/home/liveuser/.config
CONFIGS  = alacritty,bspwm,conky,i3,kitty,polybar,sxhkd

ISO   = virbos-$(shell date '+%Y.%m.%d')-x86_64.iso
CKSUM = ${ISO}.sha256

ifneq (${VERBOSE},)
	MKARCHISOFLAGS += -v
endif

all: ${ISO} ${CKSUM}

${ISO}:
	@# Download configs
	rm -rf airootfs/home/liveuser/.config
	mkdir -p tmp ${CONFDIR}
	git clone -q ${CONFREPO} tmp/configs
	cp -Rf tmp/configs/{${CONFIGS}} airootfs/home/liveuser/.config
	cp -f pacman.conf airootfs/etc/pacman.conf
	@# Build ISO
	${MKARCHISO} ${MKARCHISOFLAGS}
	mv out/${ISO} .

checksum: ${CKSUM}
${CKSUM}: ${ISO}
	@# Generate checksum
	cksum -a sha256 ${ISO} >${CKSUM}

test:
	run_archiso -i virbos-*.*.*-x86_64.iso

clean:
	rm -rf virbos-*.*.*-x86_64.iso* iso out tmp airootfs/{home/liveuser/.config,etc/pacman.conf}

.PHONY: all checksum clean test
