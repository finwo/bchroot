all:
	rm -rf rootfs
	mkdir -p rootfs/bin
	gcc -Os -s src/init.c -o rootfs/bin/init
	gcc -Os -s src/tcpd.c -o rootfs/bin/tcpd
	ldd rootfs/bin/init | grep "=> /" | awk '{print $$3}' | xargs -I '{}' install -D '{}' rootfs'{}'
	ldd rootfs/bin/tcpd | grep "=> /" | awk '{print $$3}' | xargs -I '{}' install -D '{}' rootfs'{}'
