#	$Id$

.PHONY: all install

all: rc .vimrc

install: all
	@cp rc/.??* ${HOME}/

rc:
	mkdir -p rc

.vimrc: dot.vimrc
	cp dot.vimrc rc/.vimrc
