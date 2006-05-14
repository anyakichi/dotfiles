#	$Id$

RCDIR=	rc
FILES=	\
	${RCDIR}/.cvsrc		\
	${RCDIR}/.mailcap	\
	${RCDIR}/.muttrc	\
	${RCDIR}/.profile	\
	${RCDIR}/.subversion	\
	${RCDIR}/.vim		\
	${RCDIR}/.vimrc		\
	${RCDIR}/.zlogin	\
	${RCDIR}/.zshenv	\
	${RCDIR}/.zshrc

.PHONY: all install clean

all: ${RCDIR} ${FILES}

install: all
	@cp -r ${RCDIR}/.??* ${HOME}/

clean:
	rm -rf ${RCDIR}

${RCDIR}:
	mkdir -p ${RCDIR}

${RCDIR}/.cvsrc: dot.cvsrc
	cp $? $@

${RCDIR}/.mailcap: dot.mailcap
	cp $? $@

${RCDIR}/.muttrc: dot.muttrc
	cp $? $@

${RCDIR}/.profile: dot.profile
	cp $? $@

${RCDIR}/.subversion: dot.subversion
	cp -r $? $@
	find rc -name CVS | xargs rm -rf

${RCDIR}/.vim: dot.vim
	cp -r $? $@
	find rc -name CVS | xargs rm -rf

${RCDIR}/.vimrc: dot.vimrc
	cp $? $@

${RCDIR}/.zlogin: dot.zlogin
	cp $? $@

${RCDIR}/.zshenv: dot.zshenv
	cp $? $@

${RCDIR}/.zshrc: dot.zshrc
	cp $? $@
