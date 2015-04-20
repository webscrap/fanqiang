#!/usr/bin/perl -w
use strict;
use warnings;
my %ip;
foreach(<>) {
	if(m/(\d+\.\d+\.\d+\.\d+)/) {
		$ip{$1} = 1;
	}
}
print join("\n",keys %ip),"\n";
