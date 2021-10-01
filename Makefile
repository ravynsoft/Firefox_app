APP=Firefox
SRCS=Firefox.mm
MK_DEBUG_FILES=no
RESOURCES=firefox.icns
SLF=/System/Library/Frameworks
FRAMEWORKS=${SLF}/Foundation

UID!= id -u
.if ${UID} > 0
SUDO= sudo
.endif

build: clean all firefox install

prep:
	git clone https://github.com/mszoek/airyx.git
	mv /usr/ports /usr/ports.old
	${MAKE} -C airyx getports

firefox:
	${SUDO} cp -f patch-* /usr/ports/www/firefox/files/
	${SUDO} sed -i_ -e 's@^post-install:@&\n\tmkdir -p $${STAGEDIR}$${PREFIX}/share/applications@' /usr/ports/www/firefox/Makefile
	${SUDO} ${MAKE} -C /usr/ports/www/firefox build stage

install:
	cp -a /usr/ports/www/firefox/work/stage/* ./${APP_DIR}/Contents/Resources/
	tar -cJf ${APP_DIR}.txz ${APP_DIR}

clean:
	rm -rf ${.CURDIR}/${APP_DIR}
	rm -f ${APP}.o

.include <airyx.app.mk>
