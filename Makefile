PREFIX   := /usr/local
MANDIR   := ${PREFIX}/share/man/man1
BINDIR   := ${PREFIX}/bin

NAME     := setroot
CC       := cc
OFLAG    :=
CFLAGS   := -std=c99 -Wall -g -Wextra ${OFLAG}
LIBS     := -I /usr/X11R6/include/ -I /usr/local/include/ -lX11 `imlib2-config --libs`

SRC      := setroot.c

ifeq (${xinerama},1)
DEFINES  := -DHAVE_LIBXINERAMA
INCLUDES := -I/usr/include/X11/extensions
LIBS     += -lXinerama
endif

all:
	${CC} ${SRC} ${CFLAGS} ${DEFINES} ${INCLUDES} ${LIBS} -o ${NAME}

install: ${NAME} man/${NAME}.1
	mkdir -p         ${DESTDIR}${BINDIR}
	mkdir -p         ${DESTDIR}${MANDIR}
	cp ${NAME}       ${DESTDIR}${BINDIR}
	cp man/${NAME}.1 ${DESTDIR}${MANDIR}

uninstall:
	rm -rf -i ${DESTDIR}${BINDIR}/${NAME}
	rm -rf -i ${DESTDIR}${MANDIR}/${NAME}.1

clean:
	rm -f ${NAME}
