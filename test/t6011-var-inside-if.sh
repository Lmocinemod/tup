#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2009-2023  Mike Shal <marfey@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# Make sure if a variable is set inside an if statement (and used within that
# if statement), we don't care that it is unset.
. ./tup.sh
cat > Tupfile << HERE
VAR = 0
ifeq (\$(VAR),1)
CC = gcc
: foreach *.c |> \$(CC) -c %f -o %o |> %B.o
endif
HERE

touch foo.c
update

eotup
