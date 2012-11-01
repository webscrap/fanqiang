#!/usr/bin/perl -w

my @args = @ARGV;

if(!@args) {
	print STDERR "Reading ip from STDIN:\n";
	while(<STDIN>) {
		chomp;
		push @args,$_;
	}
}
system("sudo","netselect","-vv",@args);
