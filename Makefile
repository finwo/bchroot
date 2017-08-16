all:
	rm -rf rootfs
	mkdir -p rootfs/bin
	gcc -Os -s src/init.c  -o rootfs/bin/init
	gcc -Os -s src/shell.c -o rootfs/bin/sh
	gcc -Os -s src/tcpd.c  -o rootfs/bin/tcpd
	ldd rootfs/bin/init | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/sh   | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/tcpd | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
