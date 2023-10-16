MKARCHISO      = mkarchiso
MKARCHISOFLAGS = -Avirbos -Cpacman.conf -LVIRBOS_ISO -wiso -v .

CONFREPO = https://github.com/Virbos/virbos-configs
CONFDIR  = airootfs/home/liveuser/.config
CONFIGS  = bspwm,conky,i3,kitty,polybar,sxhkd,wezterm

ISO   = virbos-$(shell date '+%Y.%m.%d')-x86_64.iso
CKSUM = ${ISO}.sha256

ifneq (${VERBOSE},)
	MKARCHISOFLAGS += -v
endif

all: ${ISO} ${CKSUM}

configs:
	@printf '==> Installing configurations\n'
	@rm -rf airootfs/home/liveuser/.config tmp
	@mkdir -p ${CONFDIR}
	@git clone -q ${CONFREPO} tmp
	@cp -Rf tmp/{${CONFIGS}} airootfs/home/liveuser/.config
	@cp -f pacman.conf airootfs/etc/pacman.conf

iso: ${ISO}
${ISO}: configs
	@printf '==> Building ISO image\n'
	@printf '%s %s\n' "${MKARCHISO}" "${MKARCHISOFLAGS}"
	@sudo ${MKARCHISO} ${MKARCHISOFLAGS}
	@sudo mv out/${ISO} .

checksum: ${CKSUM}
${CKSUM}: ${ISO}
	@# Generate checksum
	cksum -a sha256 ${ISO} >${CKSUM}

test:
	run_archiso -i virbos-*.*.*-x86_64.iso

clean:
	rm -rf virbos-*.*.*-x86_64.iso* iso out tmp airootfs/{home/liveuser/.config,etc/pacman.conf}

.PHONY: all checksum clean configs iso test
