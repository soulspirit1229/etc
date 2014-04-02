#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
#                                                                              #
#  Alger Hoi <algerhoi@gmail.com>                                     Makefile #
#                                                                              #
#  Makefile to setup new dev box                                               #
#                                                                              #
#                                                                       [n=80] #
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
export SHELL := /bin/bash
export SSH = ssh

#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Rules "
all: vim
	@echo "$(VERB) make all"

vim: .vim/bundle/vundle
	@echo "$(VERB) make vim"
	vim +BundleInstall +qall 2>/dev/null

.vim/bundle/vundle:
	@echo "$(VERB) make .vim/bundle/vundle"
	time git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

deploy:
	@echo "$(VERB) make deploy TARGET=${TARGET}"
	${SSH} ${TARGET} git clone https://github.com/algerhoi/etc.git || true
	${SSH} ${TARGET} mv '~/etc/.git' '~' || true
	${SSH} ${TARGET} rm -fr etc
	${SSH} ${TARGET} git reset --hard
	${SSH} ${TARGET} make -j vim

.PHONY: all vim
