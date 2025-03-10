#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2013-2023  Mike Shal <marfey@gmail.com>
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

# Make sure parsing foo/ after writing another file there doesn't fail, now
# with gitignore.

. ./tup.sh

mkdir foo
cat > Tupfile << HERE
: |> echo hey > %o |> foo/bar.txt
HERE
update

cat > foo/Tupfile << HERE
.gitignore
: |> echo foo > %o |> baz.txt
HERE
update

gitignore_good baz.txt foo/.gitignore
gitignore_good bar.txt foo/.gitignore

eotup
