#
# Makefile:
# 	Make rc tree
#

RCDIR=	rc
FILES=	\
	${RCDIR}/.cvsrc		\
	${RCDIR}/.hgrc		\
	${RCDIR}/.mailcap	\
	${RCDIR}/.mlterm	\
	${RCDIR}/.muttrc	\
	${RCDIR}/.profile	\
	${RCDIR}/.screenrc	\
	${RCDIR}/.subversion	\
	${RCDIR}/.termcap	\
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

${RCDIR}/.hgrc: dot.hgrc
	cp $? $@

${RCDIR}/.mailcap: dot.mailcap
	cp $? $@

${RCDIR}/.mlterm: dot.mlterm
	cp -r $? $@

${RCDIR}/.mutt: dot.mutt
	cp -r $? $@

${RCDIR}/.muttrc: dot.muttrc
	cp $? $@

${RCDIR}/.profile: dot.profile
	cp $? $@

${RCDIR}/.screenrc: dot.screenrc
	cp $? $@

${RCDIR}/.subversion: dot.subversion
	cp -r $? $@

${RCDIR}/.termcap: dot.termcap
	cp $? $@

${RCDIR}/.vim: dot.vim
	cp -r $? $@

${RCDIR}/.vimrc: dot.vimrc
	cp $? $@

${RCDIR}/.zlogin: dot.zlogin
	cp $? $@

${RCDIR}/.zshenv: dot.zshenv
	cp $? $@

${RCDIR}/.zshrc: dot.zshrc
	cp $? $@
