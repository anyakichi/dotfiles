#	$Id$

RCDIR=	rc
FILES=	${RCDIR}/.muttrc	\
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

${RCDIR}/.vimrc: dot.vimrc
	cp dot.vimrc ${RCDIR}/.vimrc

${RCDIR}/.muttrc: dot.muttrc
	cp dot.muttrc ${RCDIR}/.muttrc

${RCDIR}/.zshrc: dot.zshrc
	cp dot.zshrc ${RCDIR}/.zshrc
