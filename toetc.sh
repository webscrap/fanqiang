#!/bin/sh

dst=/etc/hosts
src=hosts.unix
if [ "$OSTYPE" == "cygwin" ] ; then
	echo Cygwin system:
	dst=`cygpath -u "$WINDIR"`
	dst=$dst/System32/drivers/etc/hosts
	src=hosts.windows
fi

echo cp -av "$src" "$dst"
cp -av "$src" "$dst"


