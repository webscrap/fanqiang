#!/usr/bin/perl -w
use strict;
use warnings;


sub netselect {
	open FI,'-|','sudo','netselect','-v',@_;
	my $msg = join("",<FI>);
	close FI;
	if($msg =~ m/\s*\d+\s+([\d\.]+)/) {
		return $1;
	}
	return "";
}

our $GOOGLE;
do "google.pm";

foreach(@ARGV) {
	my $table = $GOOGLE->{$_};
	if($table) {
		print STDERR "Select fastest ip for $_:\n";
		print join("\n",netselect(@{$table})),"\n";
	}
	else {
		print STDERR "no ip found for $_ in \"google.pm\"\n";
	}
}
