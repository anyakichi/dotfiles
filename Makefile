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
	cp $> $@

${RCDIR}/.muttrc: dot.muttrc
	cp $> $@

${RCDIR}/.vimrc: dot.vimrc
	cp $> $@

${RCDIR}/.zshrc: dot.zshrc
	cp $> $@
