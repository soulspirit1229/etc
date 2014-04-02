#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
#                                                                              #
#  Alger Hoi <algerhoi@gmail.com>                                     Makefile #
#                                                                              #
#  Makefile to setup new dev box                                               #
#                                                                              #
#                                                                       [n=80] #
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
export SHELL := /bin/bash
export SCP = scp -o "StrictHostKeyChecking no"
export SSH = ssh -o "StrictHostKeyChecking no"

# Coloring
color=\x1b[$(1)m
RESET=\x1b[0m

# http://jamesdolan.blogspot.hk/2009/10/color-coding-makefile-output.html
VERB=$(call color,35;01)[VERB]$(RESET)    # green
INFO=$(call color,32;01)[INFO]$(RESET)    # green
DEBUG=$(call color,34;01)[DEBUG]$(RESET)  # blue
WARN=$(call color,33;01)[WARN]$(RESET)    # yellow
ERR=$(call color,31;01)[ERR]$(RESET)      # red

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
	${SSH} ${TARGET} make -j .vim/bundle/vundle

.PHONY: all vim
