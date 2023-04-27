MKARCHISO = mkarchiso

all: virbos-*.*.*-x86_64.iso

virbos-*.*.*-x86_64.iso:
	${MKARCHISO} -Avirbos -Cpacman.conf -Lvirbosiso -v -wiso .
	mv out/virbos-*.*.*-x86_64.iso .
	rm -rf out

clean:
	rm -rf iso out

.PHONY: clean
