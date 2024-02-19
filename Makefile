MKARCHISO      = mkarchiso
MKARCHISOFLAGS = -Avirbos -Cpacman.conf -LVIRBOS_ISO -wiso

CONFREPO = https://github.com/Virbos/virbos-configs
CONFDIR  = airootfs/home/liveuser/.config
CONFIGS  = bspwm conky i3 kitty polybar sxhkd wezterm

ISO   = virbos-$(shell date '+%Y.%m.%d')-x86_64.iso
CKSUM = ${ISO}.sha256

ifneq (${VERBOSE},)
	MKARCHISOFLAGS += -v
endif

all: ${ISO} ${CKSUM}

configs:
	@printf '==> Installing configurations\n'
	@rm -rf $@ ${CONFDIR}
	@mkdir -p ${CONFDIR}
	@git clone -q ${CONFREPO} $@
	@cd $@ && cp -Rf ${CONFIGS} ../airootfs/home/liveuser/.config
	@cp -f pacman.conf airootfs/etc/pacman.conf

iso: ${ISO}
${ISO}: configs
	@printf '==> Building ISO image\n'
	${MKARCHISO} ${MKARCHISOFLAGS} .
	@mv out/${ISO} .
isoname:
	@printf '%s\n' "${ISO}"

checksum: ${CKSUM}
${CKSUM}: ${ISO}
	cksum -a sha256 ${ISO} >${CKSUM}

test:
	run_archiso -i virbos-*.*.*-x86_64.iso

clean:
	rm -rf ${ISO} iso out configs \
		airootfs/home/liveuser/.config \
		airootfs/etc/pacman.conf

.PHONY: all checksum clean iso isoname test
.SHELL: /usr/bin/env sh
