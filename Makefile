#	$Id$

RCDIR=	rc
FILES=	\
	${RCDIR}/.cvsrc		\
	${RCDIR}/.muttrc	\
	${RCDIR}/.vimrc		\
	${RCDIR}/.zshrc

.PHONY: all install clean

all: ${RCDIR} ${FILES}

install: all
	@cp ${RCDIR}/.??* ${HOME}/

clean:
	rm -rf ${RCDIR}

${RCDIR}:
	mkdir -p ${RCDIR}

${RCDIR}/.cvsrc: dot.cvsrc
	cp ${.ALLSRC} ${.TARGET}

${RCDIR}/.muttrc: dot.muttrc
	cp ${.ALLSRC} ${.TARGET}

${RCDIR}/.vimrc: dot.vimrc
	cp ${.ALLSRC} ${.TARGET}

${RCDIR}/.zshrc: dot.zshrc
	cp ${.ALLSRC} ${.TARGET}
