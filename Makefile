MKARCHISO = mkarchiso

virbos.iso:
	${MKARCHISO} -Avirbos -Cpacman.conf -Lvirbosiso -v -wiso .
