#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2012-2023  Mike Shal <marfey@gmail.com>
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

# Make sure we can use gcc --coverage

. ./tup.sh

check_tup_no_suid

cat > Tupfile << HERE
: |> ^c^ gcc --coverage foo.c -o %o |> foo | foo.gcno
HERE

cat > foo.c << HERE
#include <stdio.h>
int main(int argc, char **argv)
{
	if(argc > 1) {
		return 0;
	} else {
		return 1;
	}
}
HERE

touch foo.c Tupfile
update_fail_msg "tup error: This process requires namespacing, but this kernel does not support namespacing and tup is not privileged."

eotup
