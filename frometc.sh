#!/bin/sh

src=/etc/hosts
dst=hosts.unix
if [ "$OSTYPE" == "cygwin" ] ; then
	echo Cygwin system:
	src=`cygpath -u "$WINDIR"`
	src=$src/System32/drivers/etc/hosts
	dst=hosts.windows
fi

echo cp -av "$src" "$dst"
cp -av "$src" "$dst"


