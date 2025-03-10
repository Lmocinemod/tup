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

# Test for node-variables getting set multiple times (through multiple
# Tuprules.tup inclusion)

. ./tup.sh

mkdir sw
mkdir sw/lib
mkdir sw/app
mkdir sw/app/core
mkdir sw/test

cat > sw/Tuprules.tup << HERE
&lib_tupfile = lib/Tupfile
&core_tupfile = app/core/Tupfile
vars += sw
!vars = |> echo \$(vars) > %o |>
HERE

cat > sw/lib/Tupfile << HERE
include_rules
vars += lib

ifeq (\$(TUP_CWD),.)
: |> !vars |> lib.txt
endif
HERE

cat > sw/app/Tuprules.tup << HERE
vars += app
HERE

cat > sw/app/core/Tupfile << HERE
include_rules
include &(lib_tupfile)
vars += core

ifeq (\$(TUP_CWD),.)
: |> !vars |> core.txt
endif
HERE

cat > sw/test/Tupfile << HERE
include_rules
include &(core_tupfile)
vars += test
: |> !vars |> test.txt
HERE

update

tup_dep_exist sw/lib 'echo sw lib > lib.txt' sw/lib lib.txt
tup_dep_exist sw/app/core 'echo sw app sw lib core > core.txt' sw/app/core core.txt
tup_dep_exist sw/test 'echo sw sw app sw lib core test > test.txt' sw/test test.txt

eotup
