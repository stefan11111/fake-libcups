.POSIX:

XCFLAGS = ${CFLAGS} -nostdlib -std=c99

all:
	${CC} ${XCFLAGS} -fPIC -nostdlib libcups.c -o libcups.so.2 ${LDFLAGS} -shared -Wl,-soname,libcups.so.2
	${CC} ${XCFLAGS} -fPIC -nostdlib libcupsimage.c -o libcupsimage.so.2 ${LDFLAGS} -shared -Wl,-soname,libcupsimage.so.2

install:
	mkdir -p ${DESTDIR}/usr/lib64
	cp -f libcups.so.2 ${DESTDIR}/usr/lib64/libcups.so.2
	ln -rsf ${DESTDIR}/usr/lib64/libcups.so ${DESTDIR}/usr/lib64/libcups.so
	cp -f libcupsimage.so.2 ${DESTDIR}/usr/lib64/libcupsimage.so.2
	ln -rsf ${DESTDIR}/usr/lib64/libcupsimage.so ${DESTDIR}/usr/lib64/libcupsimage.so
	mkdir -p ${DESTDIR}/usr/include
	cp -rf headers ${DESTDIR}/usr/include/cups
	mkdir -p ${DESTDIR}/usr/lib64/pkgconfig
	cp -f cups.pc ${DESTDIR}/usr/lib64/pkgconfig/cups.pc

uninstall:
	rm -f ${DESTDIR}/usr/lib64/libcups.so.2
	rm -f ${DESTDIR}/usr/lib64/libcups.so
	rm -f ${DESTDIR}/usr/lib64/libcupsimage.so.2
	rm -f ${DESTDIR}/usr/lib64/libcupsimage.so
	rm -rf ${DESTDIR}/usr/include/cups
	rm -f ${DESTDIR}/usr/lib64/cups.pc

clean:
	rm -f libcups.so.2 libcupsimage.so.2

.PHONY: all clean install uninstall
