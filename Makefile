all:
	rm -rf rootfs
	mkdir -p rootfs/bin
	./cp rootfs /bin/ls
	gcc -Os -s src/clear.c -o rootfs/bin/clear
	gcc -Os -s src/echo.c  -o rootfs/bin/echo
	gcc -Os -s src/httpd.c -o rootfs/bin/httpd
	gcc -Os -s src/httpr.c -o rootfs/bin/httpr
	gcc -Os -s src/init.c  -o rootfs/bin/init
	gcc -Os -s src/shell.c -o rootfs/bin/sh
	gcc -Os -s src/tcpd.c  -o rootfs/bin/tcpd
	ldd rootfs/bin/clear | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/echo  | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/httpd | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/httpr | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/init  | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/ls    | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/sh    | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	ldd rootfs/bin/tcpd  | grep "/" | sed 's/^[^/]*//' | awk '{print $$1}' | xargs -I '{}' ./cp rootfs '{}'
	mkdir -p rootfs/etc/sv
	ln -s /bin/httpd rootfs/etc/sv/httpd
	ln -s /bin/sh    rootfs/etc/sv/sh
