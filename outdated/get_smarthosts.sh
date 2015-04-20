#!/bin/sh
exec curl --url http://smarthosts.googlecode.com/svn/trunk/hosts -o smarthosts "$@"
