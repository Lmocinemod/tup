#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2014-2023  Mike Shal <marfey@gmail.com>
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

# Try to generate a shell script that builds the project.

. ./tup.sh

# 'tup generate' runs without a tup directory
rm -rf .tup

mkdir sub1
mkdir sub2
cat > Tuprules.tup << HERE
: foreach *.c |> ^ CC %f^ gcc -c %f -o %o |> %B.o
HERE
echo 'int foo;' > foo.c
echo 'int bar;' > sub1/bar.c
echo 'int bar2;' > sub1/bar2.c
echo 'int baz;' > sub2/baz.c
echo 'int baz2;' > sub2/baz2.c
echo 'include_rules' > Tupfile
cp Tupfile sub1
cp Tupfile sub2
echo ': *.o sub1/*.o sub2/*.o |> ar cr %o %f |> libfoo.a' >> Tupfile

case $tupos in
CYGWIN*)
	expected="@echo OFF"
	;;
*)
	expected="^#! /bin/sh -e$"
	;;
esac

generate $generate_script_name
./$generate_script_name
sym_check libfoo.a foo bar bar2 baz baz2

if ! grep "$expected" $generate_script_name > /dev/null; then
	echo "Error: Expected $expected in generated script" 1>&2
	exit 1
fi

eotup
