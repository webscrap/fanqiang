#!/bin/sh

exec cat | ./getips.pl | ./netselect.pl

