#	$Id$

.PHONY: all install clean

all: rc .muttrc .vimrc

install: all
	@cp rc/.??* ${HOME}/

clean:
	rm -rf rc

rc:
	mkdir -p rc

.vimrc: dot.vimrc
	cp dot.vimrc rc/.vimrc

.muttrc: dot.muttrc
	cp dot.muttrc rc/.muttrc
