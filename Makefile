.POSIX:

XCFLAGS = ${CFLAGS} -nostdlib -std=c99

LIBDIR = /lib64

all:
	${CC} ${XCFLAGS} -fPIC -nostdlib libcups.c -o libcups.so.2 ${LDFLAGS} -shared -Wl,-soname,libcups.so.2
	${CC} ${XCFLAGS} -fPIC -nostdlib libcupsimage.c -o libcupsimage.so.2 ${LDFLAGS} -shared -Wl,-soname,libcupsimage.so.2

install:
	mkdir -p ${DESTDIR}/usr/${LIBDIR}
	cp -f libcups.so.2 ${DESTDIR}/usr${LIBDIR}/libcups.so.2
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libcups.so ${DESTDIR}/usr${LIBDIR}/libcups.so
	cp -f libcupsimage.so.2 ${DESTDIR}/usr${LIBDIR}/libcupsimage.so.2
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libcupsimage.so ${DESTDIR}/usr${LIBDIR}/libcupsimage.so
	mkdir -p ${DESTDIR}/usr/include
	cp -rf headers ${DESTDIR}/usr/include/cups
	mkdir -p ${DESTDIR}/usr${LIBDIR}/pkgconfig
	sed -e 's/__libdir/\${LIBDIR}/g' cups.pc.in cups.pc
	cp -f cups.pc ${DESTDIR}/usr${LIBDIR}/pkgconfig/cups.pc

uninstall:
	rm -f ${DESTDIR}/usr${LIBDIR}/libcups.so.2
	rm -f ${DESTDIR}/usr${LIBDIR}/libcups.so
	rm -f ${DESTDIR}/usr${LIBDIR}/libcupsimage.so.2
	rm -f ${DESTDIR}/usr${LIBDIR}/libcupsimage.so
	rm -rf ${DESTDIR}/usr/include/cups
	rm -f ${DESTDIR}/usr${LIBDIR}/cups.pc

clean:
	rm -f libcups.so.2 libcupsimage.so.2

.PHONY: all clean install uninstall
