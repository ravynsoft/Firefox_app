APP=Firefox
SRCS=Firefox.mm
MK_DEBUG_FILES=no
RESOURCES=firefox.icns
SLF=/System/Library/Frameworks
FRAMEWORKS=${SLF}/Foundation

build: clean all prep firefox install

prep:
	git clone https://github.com/mszoek/airyx.git
	mv /usr/ports /usr/ports.old
	${MAKE} -C airyx getports

firefox:
	${SUDO} cp -f patch-unity_menubar /usr/ports/www/firefox/files/
	${SUDO} ${MAKE} -C /usr/ports/www/firefox build

install:
	cp -a /usr/ports/www/firefox/work/stage/* ./${APP_DIR}/Contents/Resources/
	tar -cJf ${APP_DIR}.txz ${APP_DIR}

clean:
	rm -rf ${.CURDIR}/${APP_DIR}
	rm -f ${APP}.o

.include <airyx.app.mk>
