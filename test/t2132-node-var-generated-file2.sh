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

# Test that a node-variable can't refer to a generated file from a previous
# build (ie: in the delete list).

. ./tup.sh

cat > Tupfile << HERE
: |> touch %o |> a.txt
HERE

update

cat > Tupfile <<HERE
&node_var = a.txt
HERE

update_fail_msg "Node-variables can only refer to normal files and directories, not a 'generated file'."

eotup
