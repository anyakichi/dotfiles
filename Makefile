#
# Makefile:
# 	Make rc tree
#

RCDIR=	rc
FILES=	\
	${RCDIR}/.cvsrc		\
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

${RCDIR}/.mailcap: dot.mailcap
	cp $? $@

${RCDIR}/.mlterm: dot.mlterm
	cp -r $? $@
	find rc -name .svn | xargs rm -rf

${RCDIR}/.mutt: dot.mutt
	cp -r $? $@
	find rc -name .svn | xargs rm -rf

${RCDIR}/.muttrc: dot.muttrc
	cp $? $@

${RCDIR}/.profile: dot.profile
	cp $? $@

${RCDIR}/.screenrc: dot.screenrc
	cp $? $@

${RCDIR}/.subversion: dot.subversion
	cp -r $? $@
	find rc -name .svn | xargs rm -rf

${RCDIR}/.termcap: dot.termcap
	cp $? $@

${RCDIR}/.vim: dot.vim
	cp -r $? $@
	find rc -name .svn | xargs rm -rf

${RCDIR}/.vimrc: dot.vimrc
	cp $? $@

${RCDIR}/.zlogin: dot.zlogin
	cp $? $@

${RCDIR}/.zshenv: dot.zshenv
	cp $? $@

${RCDIR}/.zshrc: dot.zshrc
	cp $? $@
