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

# Check that static binning with a varsed rule works.

. ./tup.sh
check_no_ldpreload varsed
cat > Tupfile << HERE
: foo.txt |> tup varsed %f %o |> out.txt {txt}
: foreach {txt} |> cp %f %o |> %B.copied
HERE
echo "hey @FOO@ yo" > foo.txt
varsetall FOO=sup
update

echo "hey sup yo" | diff out.copied -
check_not_exist foo.copied

eotup
