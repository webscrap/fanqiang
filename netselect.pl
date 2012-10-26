#!/usr/bin/perl -w
use strict;
use warnings;
use lib '.';
use IPTable;
our $IPTable;

sub netselect {
	open FI,'-|','sudo','netselect','-vv',@_;
	my $msg = join("",<FI>);
	close FI;
	if($msg =~ m/\s*\d+\s+([\d\.]+)/) {
		return $1;
	}
	return "";
}

foreach(@ARGV) {
	my $table = $IPTable->{$_};
	if($table) {
		print STDERR "Select fastest ip for $_:\n";
		print join("\n",netselect(@{$table})),"\n";
	}
	else {
		print STDERR "no ip found for $_ in \"google.pm\"\n";
	}
}
