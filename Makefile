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
	mkdir -p $@
	find "$?" -maxdepth 1 -mindepth 1 \! -name dist -exec cp -rp {} $@ \;
	find "$?/dist" -maxdepth 2 -mindepth 2 \( \
	    -name filetype.vim -o -name scripts.vim -o -name autoload -o \
	    -name colors -o -name compiler -o -name doc -o -name ftplugin -o \
	    -name indent -o -name indent -o -name keymap -o -name lang -o \
	    -name menu.vim -o -name plugin -o -name print -o -name spell -o \
	    -name syntax -o -name tutor \) \
	    -exec cp -rp {} $@ \;
	vim -e -s -u "NONE" -c ':helptags rc/.vim/doc' -c ':q'

${RCDIR}/.vimrc: dot.vimrc
	cp $? $@

${RCDIR}/.zlogin: dot.zlogin
	cp $? $@

${RCDIR}/.zshenv: dot.zshenv
	cp $? $@

${RCDIR}/.zshrc: dot.zshrc
	cp $? $@
