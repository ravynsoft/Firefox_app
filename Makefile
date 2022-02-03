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

prep: /usr/ports/.git
/usr/ports/.git:
	${SUDO} mv -f /usr/ports /usr/ports.old
	${SUDO} git clone -b airyx/2022Q1 https://github.com/airyxos/freebsd-ports.git /usr/ports

firefox:
	${SUDO} cp -f patch-* /usr/ports/www/firefox/files/
	${SUDO} ${MAKE} -C /usr/ports/www/firefox build stage

install:
	cp -a /usr/ports/www/firefox/work/stage/* ./${APP_DIR}/Contents/Resources/
	FOXVER=$$(grep ^DISTV /usr/ports/www/firefox/Makefile|cut -d= -f2|sed -e 's/[\t ]//g'); \
	       sed -e "s/__version/$${FOXVER}/g" < Info.plist > ${APP_DIR}/Contents/Info.plist
	tar -cJf ${APP_DIR}.txz ${APP_DIR}

clean:
	rm -rf ${.CURDIR}/${APP_DIR}
	rm -f ${APP}.o

.include <airyx.app.mk>
