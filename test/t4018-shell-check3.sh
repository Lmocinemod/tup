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

# See that a failed command in a string of multiple commands fails. It's rather
# silly to be force to do && between everything. Plus in the example below,
# making the seemingly innocuous change of removing 'echo bar' would cause the
# command to now break if we didn't do this.

. ./tup.sh
check_no_windows shell
cat > Tupfile << HERE
: |> echo foo; false; echo bar |>
HERE

update_fail

eotup
